#!/bin/bash
# onboard-recent-repos.sh — Onboard recently forked/starred repos to time-based dirs
#
# Onboards repos starred in the last month, using the SOURCE repo name/path
# (e.g. meta-introspector/NanoJev), creating:
#   - Mirror: ~/git/github.com/<owner>/<repo>.git
#   - Worktree: /mnt/data1/time-YYYY/MM-month/DD/<repo>/
#   - Git remotes: upstream (source), local (mirror)
#
# Usage:
#   source ~/tools/onboard-recent-repos.sh              # Onboard last month
#   source ~/tools/onboard-recent-repos.sh --since 2026-09-01  # Since specific date
#   source ~/tools/onboard-recent-repos.sh --dry-run   # Preview only
#
# Works with today.sh:
#   cd "$(source ~/tools/today.sh && pwd)" # just navigate to today
#

set -e

DRY_RUN=false
SINCE_DATE="2026-08-20"

for arg in "$@"; do
  case $arg in
    --dry-run) DRY_RUN=true; shift ;;
    --since) shift; SINCE_DATE="$1"; shift ;;
  esac
done

# ── Month name helper ────────────────────────────────────
get_month_name() {
    local num=$1
    case $num in
        01) echo "january";; 02) echo "february";; 03) echo "march";;
        04) echo "april";; 05) echo "may";; 06) echo "june";;
        07) echo "july";; 08) echo "august";; 09) echo "september";;
        10) echo "october";; 11) echo "november";; 12) echo "december";;
    esac
}

# ── Setup a single repo ──────────────────────────────────
setup_repo() {
    local REPO_PATH="$1"  # e.g. meta-introspector/NanoJev
    local REPO_DATE="$2"  # e.g. 2026-09-20
    local REPO_TYPE="$3"  # "starred" or "forked"
    
    local OWNER="${REPO_PATH%/*}"
    local REPO_NAME="${REPO_PATH##*/}"
    local YEAR=$(echo "$REPO_DATE" | cut -d'-' -f1)
    local MONTH_NUM=$(echo "$REPO_DATE" | cut -d'-' -f2)
    local DAY=$(echo "$REPO_DATE" | cut -d'-' -f3)
    local MONTH_NAME=$(get_month_name "$MONTH_NUM")
    
    # Target directory in time-based structure (per gitplan.org convention)
    local DAY_DIR="/mnt/data1/time-${YEAR}/${MONTH_NUM}-${MONTH_NAME}/${DAY}/${REPO_NAME}"
    local MIRROR_DIR="$HOME/git/github.com/${OWNER}/${REPO_NAME}.git"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📦 $REPO_PATH ($REPO_TYPE: $REPO_DATE)"
    echo "   Day:    /mnt/data1/time-${YEAR}/${MONTH_NUM}-${MONTH_NAME}/${DAY}"
    echo "   Mirror: $MIRROR_DIR"
    
    if [ "$DRY_RUN" = true ]; then
        echo "   [DRY RUN] Skipping actual git operations"
        return 0
    fi
    
    # Create day directory
    mkdir -p "/mnt/data1/time-${YEAR}/${MONTH_NUM}-${MONTH_NAME}/${DAY}"
    
    # 1. Clone mirror if missing (per gitplan.org: clone --mirror)
    if [ ! -d "$MIRROR_DIR" ]; then
        echo "   📥 Cloning mirror: git clone --mirror https://github.com/${REPO_PATH}.git"
        git clone --mirror "https://github.com/${REPO_PATH}.git" "$MIRROR_DIR" 2>/dev/null || \
            echo "   ⚠️  Mirror clone failed"
    else
        echo "   ✅ Mirror exists: $MIRROR_DIR"
    fi
    
    # 2. Add worktree to day directory (per gitplan.org)
    if [ ! -d "$DAY_DIR" ]; then
        if [ -d "$MIRROR_DIR" ]; then
            echo "   🌳 Adding worktree: git -C $MIRROR_DIR worktree add $DAY_DIR HEAD"
            git -C "$MIRROR_DIR" worktree add "$DAY_DIR" HEAD 2>/dev/null || {
                echo "   📥 Falling back to clone"
                git clone "$MIRROR_DIR" "$DAY_DIR" 2>/dev/null || true
            }
        fi
    else
        echo "   ✅ Worktree exists"
    fi
    
    # 3. Set up git remotes (per gitplan.org pattern)
    if [ -e "$DAY_DIR/.git" ]; then
        cd "$DAY_DIR"
        if ! git remote | grep -q upstream 2>/dev/null; then
            echo "   🔗 Adding upstream: https://github.com/${REPO_PATH}.git"
            git remote add upstream "https://github.com/${REPO_PATH}.git" 2>/dev/null || true
        fi
        if ! git remote | grep -q local 2>/dev/null; then
            echo "   🔗 Adding local: $MIRROR_DIR"
            git remote add local "$MIRROR_DIR" 2>/dev/null || true
        fi
        cd "$HOME"
    fi
    
    echo "   ✅ Done"
}

# ── Main ──────────────────────────────────────────────────

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║  📦 Onboard Recently Starred/Forked Repos              ║"
echo "║  Since: $SINCE_DATE                                    ║"
echo "║  Dry run: $DRY_RUN                                         ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# ── Get starred repos from last month (GraphQL) ──────────
echo "⭐ Fetching starred repos since $SINCE_DATE..."
STARRED_JSON=$(gh api graphql -f query='
query {
  viewer {
    starredRepositories(first: 100, orderBy: {field: STARRED_AT, direction: DESC}) {
      edges {
        node {
          nameWithOwner
        }
        starredAt
      }
    }
  }
}' 2>/dev/null)

if [ -n "$STARRED_JSON" ]; then
    echo "$STARRED_JSON" | python3 -c "
import sys, json, datetime
data = json.load(sys.stdin)
if 'data' in data:
    cutoff = '$SINCE_DATE'
    results = []
    for edge in data['data']['viewer']['starredRepositories']['edges']:
        full_name = edge['node']['nameWithOwner']
        starred_at = edge['starredAt']
        dt = datetime.datetime.fromisoformat(starred_at.replace('Z', '+00:00'))
        if dt.strftime('%Y-%m-%d') >= cutoff:
            results.append((dt.strftime('%Y-%m-%d'), full_name, 'starred'))
    # Sort by date, then by repo name
    results.sort()
    for date, repo, rtype in results:
        print(f'{date}|{repo}|{rtype}')
" | while IFS='|' read -r date repo rtype; do
        setup_repo "$repo" "$date" "$rtype"
    done
else
    echo "   ⚠️ Could not fetch starred repos (API issue)"
fi

# ── Get forked repos from last month ─────────────────────
echo ""
echo "🍴 Fetching forked repos since $SINCE_DATE..."
FORKED_JSON=$(gh api --paginate user/repos --jq ".[] | select(.fork==true and .parent!=null and .created_at >= \"${SINCE_DATE}T00:00:00Z\") | {full_name: .full_name, parent_full_name: .parent.full_name, created_at: .created_at}" 2>/dev/null)

if [ -n "$FORKED_JSON" ]; then
    echo "$FORKED_JSON" | python3 -c "
import sys, json, datetime
for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    try:
        d = json.loads(line)
        full_name = d['full_name']
        parent = d['parent_full_name']
        created_at = d['created_at']
        dt = datetime.datetime.fromisoformat(created_at.replace('Z', '+00:00'))
        # Use the SOURCE repo path (parent) for naming
        print(f'{dt.strftime(\"%Y-%m-%d\")}|{parent}|forked')
    except:
        pass
" | sort | while IFS='|' read -r date repo rtype; do
        setup_repo "$repo" "$date" "$rtype"
    done
else
    echo "   ⚠️ Could not fetch forked repos"
fi

# ── Summary ──────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "✅ Onboarding complete!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  • Run 'source ~/tools/today.sh' to cd to today"
echo "  • Review worktrees in their day directories"
echo "  • Use 'today clone <owner>/<repo>' for individual repos"
echo "  • Use 'today plan' to see gitplan.org entries"