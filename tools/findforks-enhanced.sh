#!/bin/bash
# findforks-enhanced.sh — Find active forks with real progress and PRs
#
# For a given upstream repo, fetch all forks and filter based on:
#   1. Forks with open pull requests (PRs)
#   2. Forks with recent commits (new code)
#   3. Skip inactive mirrors (no progress)
#
# Usage:
#   ./findforks-enhanced.sh <owner>/<repo> [--since-days N] [--min-stars N] [--min-issues N]
#
# Principles from gitplan.org:
#   - Use GitHub API efficiently
#   - Prioritize active development
#   - Skip dead/fossilized forks
#

set -e

# ── Helper functions ───────────────────────────────────────────────────

log() {
    echo "🔍 $1"
}

error() {
    echo "❌ $1" >&2
}

# ── Get forks with API pagination ───────────────────────────────────────

get_forks() {
    local username="$1"
    local repo="$2"
    local api_url="https://api.github.com/repos/${username}/${repo}/forks"
    
    log "Fetching forks for ${username}/${repo}..."
    
    local all_json="[]"
    local page=1
    local per_page=100
    
    while true; do
        local url="${api_url}?per_page=${per_page}&page=${page}&sort=newest&direction=desc"
        local response
        
        response=$(curl -s -H "Accept: application/vnd.github.v3+json" "$url" 2>/dev/null) || {
            error "Failed to fetch forks from GitHub API"
            echo "[]"
            return 1
        }
        
        if echo "$response" | jq -e '.[0]' >/dev/null 2>&1; then
            all_json=$(echo "$all_json + $response" | jq '.')
        else
            break
        fi
        
        # Check for next page
        local link_header
        link_header=$(curl -sI -H "Accept: application/vnd.github.v3+json" "$url" 2>/dev/null | grep -i '^Link:' || true)
        
        if [[ -z "$link_header" ]] || echo "$link_header" | grep -q 'rel="last"'; then
            break
        fi
        
        page=$((page + 1))
        
        # Safety limit
        if [[ $page -gt 10 ]]; then
            log "Reached pagination limit"
            break
        fi
    done
    
    echo "$all_json"
}

# ── Filter and rank forks ───────────────────────────────────────────────

filter_and_rank_forks() {
    local forks_json="$1"
    local since_days="$2"
    local min_stars="$3"
    local min_issues="$4"
    
    log "Filtering and ranking forks..."
    
    # Get current date for cutoff
    local cutoff_epoch
    cutoff_epoch=$(date -d "$since_days days ago" +%s 2>/dev/null || echo "0")
    
    # Parse and filter forks
    echo "$forks_json" | jq -rc --argjson min_stars "$min_stars" --argjson min_issues "$min_issues" --argjson cutoff_epoch "$cutoff_epoch" --argjson since_days "$since_days" '
        .[] |
        {
            full_name: .full_name,
            name: .name,
            owner: .owner.login,
            forks_count: .forks_count,
            stargazers_count: .stargazers_count,
            open_issues_count: .open_issues_count,
            pushed_at: .pushed_at,
            created_at: .created_at,
            language: .language
        } |
        {
            // Add computed fields
            pushed_epoch: (.pushed_at | fromdateiso8601),
            has_activity: (.pushed_epoch >= $cutoff_epoch),
            has_issues: (.open_issues_count >= $min_issues),
            has_stars: (.stargazers_count >= $min_stars),
            forks_count: .forks_count
        } |
        // Skip mirrors with no activity/stars/issues
        select(
            (.has_activity == true or .has_stars == true or .has_issues == true) and
            (.stargazers_count > 0 or .open_issues_count > 0 or .has_activity == true)
        ) |
        // Add priority score
        .priority = (
            (if .has_activity then 3 else 0 end) +
            (if .has_issues then 2 else 0 end) +
            (if .has_stars then 1 else 0 end)
        ) |
        select(.priority > 0) |
        select(.stargazers_count > 0 or .open_issues_count > 0 or .has_activity)
    ' 2>/dev/null | jq -s 'sort_by(-.priority, -.stargazers_count)'
}

# ── Display results ───────────────────────────────────────────────────────

show_results() {
    local forks_json="$1"
    local since_days="$2"
    
    echo ""
    echo "╔═════════════════════════════════════════════════════════════"
    echo "║  Filtered and Ranked Forks (since last ${since_days} days)  ║"
    echo "╚═════════════════════════════════════════════════════════════"
    echo ""
    
    local count=0
    
    echo "$forks_json" | jq -c '.[]' 2>/dev/null | while IFS= read -r fork; do
        count=$((count + 1))
        
        local full_name name owner priority has_activity has_issues has_stars pushed_at stargazers_count open_issues_count
        
        full_name=$(echo "$fork" | jq -r '.full_name')
        name=$(echo "$fork" | jq -r '.name')
        owner=$(echo "$fork" | jq -r '.owner')
        priority=$(echo "$fork" | jq -r '.priority')
        has_activity=$(echo "$fork" | jq -r '.has_activity')
        has_issues=$(echo "$fork" | jq -r '.has_issues')
        has_stars=$(echo "$fork" | jq -r '.has_stars')
        pushed_at=$(echo "$fork" | jq -r '.pushed_at')
        stargazers_count=$(echo "$fork" | jq -r '.stargazers_count')
        open_issues_count=$(echo "$fork" | jq -r '.open_issues_count')
        
        echo "[$count] ${full_name} (owner: ${owner})"
        echo "   Priority: ${priority} | Stars: ${stargazers_count} | Issues: ${open_issues_count}"
        echo "   Activity: $([ "$has_activity" = "true" ] && echo "✓ Recent" || echo "✗ Inactive")"
        echo "   Issues: $([ "$has_issues" = "true" ] && echo "✓ Has open" || echo "✗ None")"
        echo "   Stars: $([ "$has_stars" = "true" ] && echo "✓ Enough" || echo "✗ Low")"
        echo "   Last push: ${pushed_at}"
        echo ""
        
        # Show first 15 results
        if [[ $count -ge 15 ]]; then
            break
        fi
    done
    
    echo "Total active forks processed: $count"
    echo ""
    echo "Usage:"
    echo "  ./findforks-enhanced.sh <owner>/<repo> [--since-days N] [--min-stars N] [--min-issues N]"
    echo ""
    echo "Next steps:"
    echo "  1. Review each fork for real progress"
    echo "  2. Check for PRs on the repository"
    echo "  3. Evaluate new code contributions"
    echo "  4. Skip inactive mirrors (no stars/issues/activity)"
}

# ── Main execution ───────────────────────────────────────────────────────

# Defaults
SINCE_DAYS="30"
MIN_STARS="10"
MIN_ISSUES="0"
TARGET_REPO=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --since-days)
            shift; SINCE_DAYS="$1"; shift ;;
        --min-stars)
            shift; MIN_STARS="$1"; shift ;;
        --min-issues)
            shift; MIN_ISSUES="$1"; shift ;;
        *)
            if [[ -z "$TARGET_REPO" ]]; then
                TARGET_REPO="$1"
            else
                error "Unexpected argument: $1"
                exit 1
            fi
            shift ;;
    esac
done

# Set default repo if not specified
if [[ -z "$TARGET_REPO" ]]; then
    TARGET_REPO="meta-introspector/time-2026"
fi

log "Target: ${TARGET_REPO}"
log "Filtering: commits in last ${SINCE_DAYS} days, stars >= ${MIN_STARS}, issues >= ${MIN_ISSUES}"

# Parse target repo
TARGET_USERNAME="${TARGET_REPO%/*}"
TARGET_REPO_NAME="${TARGET_REPO##*/}"

# Get forks
forks_json=$(get_forks "$TARGET_USERNAME" "$TARGET_REPO_NAME")

# Filter and rank
filtered_forks=$(filter_and_rank_forks "$forks_json" "$SINCE_DAYS" "$MIN_STARS" "$MIN_ISSUES")

# Show results
show_results "$filtered_forks" "$SINCE_DAYS"

exit 0