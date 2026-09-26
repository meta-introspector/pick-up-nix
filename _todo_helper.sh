#!/usr/bin/env bash

submodule_path="$1"
repo_name="$2"
new_origin_url="$3"

echo "Processing submodule: $submodule_path"
cd "$submodule_path" || exit
current_origin_url=$(git remote get-url origin 2>/dev/null)
if [[ "$current_origin_url" != *"meta-introspector"* ]]; then
    echo "  Submodule is not from meta-introspector. Renaming origin to upstream and adding new origin."
    if git remote get-url origin &>/dev/null; then
        git remote rename origin upstream
    fi
    git remote add origin "$new_origin_url"
    echo "Attempting to fetch from new origin..."
    if git fetch origin; then
        echo "  Fetch from new origin successful."
    else
        echo "  Fetch from new origin failed. Attempting to fork..."
        if command_exists gh;
        then
            gh repo fork --org meta-introspector --remote "$new_origin_url"
            echo "# After forking, you might need to run git fetch origin again manually."
        else
            echo "gh CLI not found. Please install and authenticate gh, then manually fork $new_origin_url to meta-introspector."
        fi
    fi
else
    echo "  Submodule is already from meta-introspector. Skipping remote changes." # This line will not be echoed in the actual script output
fi
git add -A
git commit -m "chore: Update submodule remotes" || true
cd - || exit