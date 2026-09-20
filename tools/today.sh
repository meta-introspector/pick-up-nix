#!/bin/bash
# today.sh — cd to today's working directory + gitplan.org automation
# Format: /mnt/data1/time-YYYY/MM-month/DD
#
# Usage:
#   source ~/tools/today.sh          # cd to today's dir, show gitplan entries
#   source ~/tools/today.sh clone <owner>/<repo>   # clone repo + worktree
#   source ~/tools/today.sh plan     # show today's gitplan.org entries
#   ~/tools/today.sh                 # executed: just print today's path
#
# When sourced, also:
#   - Creates today's directory
#   - Shows relevant gitplan.org entries for today
#   - Sets up ~/git/github.com/<owner>/<repo>.git if missing

set -e

MONTHS=(unused 01-january 02-february 03-march 04-april 05-may 06-june 07-july 08-august 09-september 10-october 11-november 12-december)
Y=$(date +%Y)
M=$(date +%-m)
D=$(date +%d)
TODAY="/mnt/data1/time-${Y}/${MONTHS[$M]}/${D}"

mkdir -p "$TODAY"

# ── Helper: show gitplan.org entries for today ──────────────────────────
show_plan() {
    local PLAN_FILE="$HOME/gitplan.org"
    if [ ! -f "$PLAN_FILE" ]; then
        echo "⚠ No gitplan.org found at $PLAN_FILE"
        return 1
    fi
    echo "📋 Today's gitplan.org entries:"
    echo "────────────────────────────────────────"
    # Show entries from today's month/day section if present
    local SECTION="${MONTHS[$M]}/${D}"
    if grep -q "$SECTION" "$PLAN_FILE" 2>/dev/null; then
        awk "/$SECTION/,/^\* |^#+end_src/" "$PLAN_FILE" | head -40
    else
        # Fallback: show first 30 lines of gitplan.org
        head -30 "$PLAN_FILE"
    fi
    echo "────────────────────────────────────────"
}

# ── Helper: clone repo + set up worktree ────────────────────────────────
clone_repo() {
    local REPO_PATH="$1"  # e.g. sub0xdai/n0x-pi
    local OWNER="${REPO_PATH%/*}"
    local REPO_NAME="${REPO_PATH##*/}"
    local MIRROR_DIR="$HOME/git/github.com/${OWNER}/${REPO_NAME}.git"
    local WORKTREE_DIR="$TODAY/${REPO_NAME}"

    echo "🔍 Checking for $REPO_PATH..."

    # 1. Clone mirror if missing
    if [ ! -d "$MIRROR_DIR" ]; then
        echo "  📥 Cloning mirror: https://github.com/${REPO_PATH}.git"
        git clone --mirror "https://github.com/${REPO_PATH}.git" "$MIRROR_DIR"
    else
        echo "  ✅ Mirror exists: $MIRROR_DIR"
    fi

    # 2. Add worktree to today's directory
    if [ ! -d "$WORKTREE_DIR" ]; then
        echo "  🌳 Adding worktree at $WORKTREE_DIR"
        git -C "$MIRROR_DIR" worktree add "$WORKTREE_DIR" HEAD 2>/dev/null || {
            # Fallback: clone fresh
            git clone "$MIRROR_DIR" "$WORKTREE_DIR"
        }
    else
        echo "  ✅ Worktree exists: $WORKTREE_DIR"
    fi

    # 3. Set up remotes (upstream + local)
    if [ -d "$WORKTREE_DIR" ]; then
        cd "$WORKTREE_DIR"
        if ! git remote | grep -q upstream; then
            echo "  🔗 Adding upstream remote"
            git remote add upstream "https://github.com/${REPO_PATH}.git"
        fi
        if ! git remote | grep -q local; then
            echo "  🔗 Adding local remote"
            git remote add local "$MIRROR_DIR"
        fi
        cd "$TODAY"
    fi

    echo ""
    echo "✅ Done. Worktree at: $WORKTREE_DIR"
}

# ── Main logic ──────────────────────────────────────────────────────────
# Auto-update ~/today symlink
if [ -L "$HOME/today" ]; then
    rm -f "$HOME/today"
fi
ln -s "$TODAY" "$HOME/today" 2>/dev/null || true

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    # Executed as script — just print today's path
    echo "$TODAY"
    exit 0
fi

# Sourced — process args
ACTION="${1:-cd}"
shift 2>/dev/null || true

case "$ACTION" in
    clone)
        if [ -z "$1" ]; then
            echo "Usage: source ~/tools/today.sh clone <owner>/<repo>"
            return 1
        fi
        clone_repo "$1"
        ;;
    plan)
        show_plan
        ;;
    cd|*)
        cd "$TODAY" || exit 1
        echo "📁 Today: $TODAY"
        show_plan
        ;;
esac