today() {
	# Usage: today [cd|clone <owner>/<repo>|plan]
	# Defaults to cd to today's directory + show gitplan.org entries
	#
	# Examples:
	#   today              # cd to today's dir, show plan
	#   today clone sub0xdai/n0x-pi   # clone mirror + worktree
	#   today plan         # show gitplan.org entries for today
	#   today cd           # just cd to today's dir
	#
	# Format: /mnt/data1/time-YYYY/MM-month/DD
	#
	local MONTHS=(unused 01-january 02-february 03-march 04-april 05-may 06-june 07-july 08-august 09-september 10-october 11-november 12-december)
	local Y=$(date +%Y)
	local M=$(date +%-m)
	local D=$(date +%d)
	local TODAY="/mnt/data1/time-${Y}/${MONTHS[$M]}/${D}"

	mkdir -p "$TODAY"

	local ACTION="${1:-cd}"
	shift 2>/dev/null || true

	case "$ACTION" in
		clone)
			if [ -z "$1" ]; then
				echo "Usage: today clone <owner>/<repo>"
				return 1
			fi
			local REPO_PATH="$1"
			local OWNER="${REPO_PATH%/*}"
			local REPO_NAME="${REPO_PATH##*/}"
			local MIRROR_DIR="$HOME/git/github.com/${OWNER}/${REPO_NAME}.git"
			local WORKTREE_DIR="$TODAY/${REPO_NAME}"

			echo "🔍 Checking for $REPO_PATH..."
			if [ ! -d "$MIRROR_DIR" ]; then
				echo "  📥 Cloning mirror: https://github.com/${REPO_PATH}.git"
				git clone --mirror "https://github.com/${REPO_PATH}.git" "$MIRROR_DIR"
			else
				echo "  ✅ Mirror exists: $MIRROR_DIR"
			fi
			if [ ! -d "$WORKTREE_DIR" ]; then
				echo "  🌳 Adding worktree at $WORKTREE_DIR"
				git -C "$MIRROR_DIR" worktree add "$WORKTREE_DIR" HEAD 2>/dev/null || git clone "$MIRROR_DIR" "$WORKTREE_DIR"
			else
				echo "  ✅ Worktree exists: $WORKTREE_DIR"
			fi
			if [ -d "$WORKTREE_DIR" ]; then
				cd "$WORKTREE_DIR"
				if ! git remote | grep -q upstream; then
					git remote add upstream "https://github.com/${REPO_PATH}.git"
				fi
				if ! git remote | grep -q local; then
					git remote add local "$MIRROR_DIR"
				fi
				cd "$TODAY"
			fi
			echo "✅ Done. Worktree at: $WORKTREE_DIR"
			;;
		plan)
			local PLAN_FILE="$HOME/gitplan.org"
			if [ -f "$PLAN_FILE" ]; then
				echo "📋 Today's gitplan.org entries:"
				echo "────────────────────────────────────────"
				head -40 "$PLAN_FILE"
				echo "────────────────────────────────────────"
			else
				echo "⚠ No gitplan.org found"
			fi
			;;
		cd|*)
			cd "$TODAY" || return 1
			echo "📁 Today: $TODAY"
			# Show gitplan entries if present
			local PLAN_FILE="$HOME/gitplan.org"
			if [ -f "$PLAN_FILE" ]; then
				echo "📋 gitplan.org entries for today:"
				head -20 "$PLAN_FILE"
			fi
			;;
	esac
}