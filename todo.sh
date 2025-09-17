#!/usr/bin/env bash

# This script acts as a state machine to guide through submodule setup and remote adjustment.
# Run it repeatedly, executing the suggested commands, until it indicates completion.

# Function to check if a command exists
command_exists () {
  type "$1" &> /dev/null ;
}

# --- State 1: Initial setup and submodule initialization ---
# Check if .gitmodules exists and if submodules are initialized
if [ ! -f .gitmodules ] || ! git submodule status &>/dev/null;
then
    echo "Submodules are not initialized or .gitmodules is missing. Run:"
    echo "git submodule init"
    exit 0
fi

# --- State 2: Submodule update and remote adjustment ---
# Check for uncommitted changes in main repo only, explicitly excluding submodules
if git status --porcelain | grep -v "^.M" | grep -q "^M"; then
    echo "Uncommitted changes detected in the main repository (excluding submodule content). Run:"
    echo "git add -A"
    echo "git commit -m \"feat: Prepare submodules and remotes\""
    exit 0
fi

# Attempt a dry-run update to see if there are issues
if git submodule update --init --dry-run &>/dev/null;
then
    echo "Submodules initialized. Attempting to update and adjust remotes. Run:"
    echo "git submodule update --init"
    echo ""
    echo "# After running the above, re-run this script. If there are remote issues, it will suggest fixes."
    exit 0
fi

# If git submodule update --init --dry-run fails, it likely means remote issues or other problems.
# We need to iterate through submodules to fix remotes.
echo "Submodule update failed or requires remote adjustment. Run the following for each submodule:"
git submodule status | while read -r line ; do
    submodule_path=$(echo "$line" | awk '{print $2}')
    repo_name=$(basename "$submodule_path")
    new_origin_url="https://github.com/meta-introspector/$repo_name"

    # Call the helper script to print commands for this submodule
    ./_todo_helper.sh "$submodule_path" "$repo_name" "$new_origin_url"
done
echo ""
echo "# After running the above commands for all submodules, re-run this script."
exit 0

# --- State 3: All clear ---
# If we reach here, it means all previous conditions were met.
echo "All submodules are up to date and remotes are configured. Main repository is clean."
echo "You can now proceed with your work or push changes."