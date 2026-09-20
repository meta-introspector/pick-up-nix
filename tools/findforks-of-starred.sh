#!/bin/bash
# findforks-of-starred.sh — Find active forks of recently starred repos
#
# For each recently starred repo (last N days), fetch its forks and filter by:
#   1. Forks with open PRs to upstream (highest priority)
#   2. Forks with recent commits (new code)
#   3. Skip inactive mirrors (no progress)
#
# Usage:
#   ./findforks-of-starred.sh [--since-days N] [--dry-run] [--onboard]
#
# Filtering priority (in order):
#   1. Has open PRs to upstream (score +5)
#   2. Recent commits since cutoff (score +3)
#   3. Has stars (score +2)
#   4. Has open issues (score +1)
#   5. Skip mirrors with zero activity/stars/issues
#

set -e

SINCE_DAYS="30"
DRY_RUN=false
ONBOARD=false
MIN_STARS="0"
MIN_FORKS="0"

for arg in "$@"; do
    case $arg in
        --since-days) shift; SINCE_DAYS="$1"; shift ;;
        --dry-run) DRY_RUN=true; shift ;;
        --onboard) ONBOARD=true; shift ;;
        --min-stars) shift; MIN_STARS="$1"; shift ;;
        --min-forks) shift; MIN_FORKS="$1"; shift ;;
    esac
done

# ── Helpers ─────────────────────────────────────────────────

log()    { echo "🔍 $1"; }
info()   { echo "   $1"; }
warn()   { echo "   ⚠️  $1" >&2; }
err()    { echo "   ❌ $1" >&2; }

get_month_name() {
    case $1 in
        01) echo "january";; 02) echo "february";; 03) echo "march";;
        04) echo "april";; 05) echo "may";; 06) echo "june";;
        07) echo "july";; 08) echo "august";; 09) echo "september";;
        10) echo "october";; 11) echo "november";; 12) echo "december";;
    esac
}

QUERY_FILE="/tmp/findforks-starred-query.graphql"

# ── Get recently starred repos ──────────────────────────────

get_recent_starred() {
    log "Fetching repos starred since $SINCE_DAYS days..."

    # Write GraphQL query to file (avoids quoting issues)
    local first_val="${1:-100}"
    cat > "$QUERY_FILE" << QEOF
query($first: Int!) {
  viewer {
    starredRepositories(first: $first, orderBy: {field: STARRED_AT, direction: DESC}) {
      edges {
        node {
          nameWithOwner
          stargazerCount
          forkCount
          pushedAt
        }
        starredAt
      }
    }
  }
}
QEOF

    # Execute query
    local response
    response=$(gh api graphql --field "query=$(cat $QUERY_FILE)" --field "first=$first_val" 2>/dev/null) || {
        warn "Failed to fetch starred repos"
        return 1
    }

    echo "$response"
}

# ── Get forks for a repo ───────────────────────────────────

get_forks_for_repo() {
    local repo="$1"
    local owner="${repo%/*}"
    local name="${repo##*/}"

    log "Fetching forks for $repo..."

    local api_url="https://api.github.com/repos/${owner}/${name}/forks?per_page=100&sort=newest"
    local response

    response=$(curl -s -H "Accept: application/vnd.github.v3+json" "$api_url" 2>/dev/null) || {
        warn "Failed to fetch forks for $repo"
        return 1
    }

    if ! echo "$response" | jq -e '.[0]' >/dev/null 2>&1; then
        log "  No forks found"
        return 1
    fi

    echo "$response"
}

# ── Check for open PRs ──────────────────────────────────────

check_prs_from_fork() {
    local fork_full_name="$1"
    local upstream="$2"
    local owner="${fork_full_name%/*}"
    local repo="${fork_full_name##*/}"

    # Count open PRs from this fork to upstream
    local pr_count
    pr_count=$(gh api "repos/${upstream}/pulls?head=${owner}:${repo}&state=open" --jq 'length' 2>/dev/null) || echo "0"

    if [[ "$pr_count" =~ ^[0-9]+$ ]] && [[ "$pr_count" -gt 0 ]]; then
        echo "$pr_count"
    else
        echo "0"
    fi
}

# ── Score and filter forks ────────────────────────────────────

score_fork() {
    local fork_data="$1"
    local upstream="$2"
    local since_epoch

    # Parse fork data
    local fork_full_name=$(echo "$fork_data" | jq -r '.full_name')
    local owner="${fork_full_name%/*}"
    local repo="${fork_full_name##*/}"
    local pushed_at=$(echo "$fork_data" | jq -r '.pushed_at // empty')
    local stargazers_count=$(echo "$fork_data" | jq -r '.stargazers_count // 0')
    local forks_count=$(echo "$fork_data" | jq -r '.forks_count // 0')
    local open_issues_count=$(echo "$fork_data" | jq -r '.open_issues_count // 0')

    # Calculate recency (relative to cutoff)
    since_epoch=$(date -d "$SINCE_DAYS days ago" +%s 2>/dev/null || echo "0")
    local has_recent=false
    if [[ -n "$pushed_at" ]] && date -d "$pushed_at" >/dev/null 2>&1; then
        local pushed_epoch
        pushed_epoch=$(date -d "$pushed_at" +%s 2>/dev/null || echo "0")
        if [[ "$pushed_epoch" -ge "$since_epoch" ]] && [[ "$pushed_epoch" -gt 0 ]]; then
            has_recent=true
        fi
    fi

    # Priority scoring
    local score=0

    # 1. Has open PRs to upstream (highest priority)
    local pr_count=$(check_prs_from_fork "$fork_full_name" "$upstream")
    if [[ "$pr_count" -gt 0 ]]; then
        score=$((score + 5))
    fi

    # 2. Recent commits since cutoff
    if [[ "$has_recent" == true ]]; then
        score=$((score + 3))
    fi

    # 3. Has stars
    if [[ "$stargazers_count" -ge "$MIN_STARS" ]]; then
        score=$((score + 2))
    fi

    # 4. Has open issues
    if [[ "$open_issues_count" -ge "$MIN_ISSUES" ]]; then
        score=$((score + 1))
    fi

    # Output: full_name|upstream|score|pr_count|has_recent|stars|issues
    echo "${fork_full_name}|${upstream}|${score}|${pr_count}|${has_recent}|${stargazers_count}|${open_issues_count}"
}

# ── Onboard a fork ────────────────────────────────────────────

onboard_fork() {
    local fork_full_name="$1"
    local repo_date="$2"
    local upstream="$3"
    local score="$4"

    local owner="${fork_full_name%/*}"
    local name="${fork_full_name##*/}"
    local year=$(echo "$repo_date" | cut -d'-' -f1)
    local month_num=$(echo "$repo_date" | cut -d'-' -f2)
    local day=$(echo "$repo_date" | cut -d'-' -f3)
    local month_name=$(get_month_name "$month_num")

    local day_dir="/mnt/data1/time-${year}/${month_num}-${month_name}/${day}/${name}"
    local mirror_dir="$HOME/git/github.com/${owner}/${name}.git"

    info "📦 $fork_full_name (score: $score, from $upstream)"
    info "   Day:    $day_dir"
    info "   Mirror: $mirror_dir"

    if [ "$DRY_RUN" = true ]; then
        info "   [DRY RUN] Skipping git operations"
        return 0
    fi

    mkdir -p "/mnt/data1/time-${year}/${month_num}-${month_name}/${day}"

    # 1. Clone mirror if missing
    if [ ! -d "$mirror_dir" ]; then
        info "   📥 Cloning mirror..."
        git clone --mirror "https://github.com/${fork_full_name}.git" "$mirror_dir" 2>/dev/null || warn "Mirror clone failed"
    else
        info "   ✅ Mirror exists"
    fi

    # 2. Add worktree
    if [ ! -d "$day_dir" ] && [ -d "$mirror_dir" ]; then
        info "   🌳 Adding worktree..."
        git -C "$mirror_dir" worktree add "$day_dir" HEAD 2>/dev/null || git clone "$mirror_dir" "$day_dir" 2>/dev/null
    else
        info "   ✅ Worktree exists"
    fi

    # 3. Set up remotes
    if [ -e "$day_dir/.git" ]; then
        cd "$day_dir"
        git remote add upstream "https://github.com/${upstream}.git" 2>/dev/null || true
        git remote add local "$mirror_dir" 2>/dev/null || true
        git remote add origin "https://github.com/${fork_full_name}.git" 2>/dev/null || true
        cd "$HOME"
    fi

    info "   ✅ Done"
}

# ── Main ──────────────────────────────────────────────────────

log "Finding active forks of recently starred repos (last $SINCE_DAYS days)"
log "Dry run: $DRY_RUN, Onboard: $ONBOARD"
log "Min stars: $MIN_STARS, Min forks: $MIN_FORKS"

# Get recently starred repos
response=$(get_recent_starred "$SINCE_DAYS") || {
    warn "No starred repos found"
    exit 0
}

# Process each starred repo
echo "$response" | python3 -c "
import sys, json, datetime

data = json.load(sys.stdin)
if 'data' not in data:
    print('No data returned', file=sys.stderr)
    sys.exit(0)

starred = data['data']['viewer']['starredRepositories']['edges']
cutoff = '$SINCE_DAYS days ago'.split()[0]  # Extract date portion
cutoff_date = cutoff.replace('-', '-')  # Keep as YYYY-MM-DD

for edge in starred:
    node = edge['node']
    repo = node['nameWithOwner']
    stars = node['stargazerCount']
    forks = node['forkCount']
    pushed = node['pushedAt'] or ''
    
    # Filter: only include repos with enough stars and forks, and recent activity
    if stars < int('$MIN_STARS') or forks < int('$MIN_FORKS'):
        continue
    
    # Only include repos since cutoff date
    if pushed:
        dt = datetime.datetime.fromisoformat(pushed.replace('Z', '+00:00'))
        cutoff_dt = datetime.datetime.strptime('$SINCE_DAYS days ago'.split()[0], '%Y-%m-%d')
        if dt < cutoff_dt:
            continue
    
    # Print for processing
    print(f'{repo}|{stars}|{forks}|{pushed}')
" | while IFS='|' read -r repo stars forks pushed; do
    
    log "Processing starred repo: $repo (★$stars, 🍴$forks, pushed: $pushed)"
    
    # Get forks for this repo
    forks_json=$(get_forks_for_repo "$repo")
    
    if [[ -z "$forks_json" ]]; then
        warn "  No forks found"
        continue
    fi
    
    # Score each fork
    scored_forks=""
    while IFS= read -r fork_line; do
        fork_score=$(score_fork "$fork_line" "$repo")
        if [[ -n "$fork_score" ]]; then
            scored_forks+="${fork_score}\n"
        fi
    done < <(echo "$forks_json" | jq -c '.[]')
    
    # Sort by score (descending) and show top results
    echo -e "$scored_forks" | sort -t'|' -k3 -rn | head -10 | while IFS='|' read -r full_name upstream score pr_count has_recent stars issues; do
        log "  [$score] $full_name (PRs: $pr_count, Stars: $stars, Issues: $issues)"
        
        if [[ "$ONBOARD" == true ]]; then
            onboard_fork "$full_name" "$pushed" "$upstream" "$score"
        fi
    done
done

log "Done"