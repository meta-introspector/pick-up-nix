#!/usr/bin/env bash

set -euo pipefail

SUBMODULE_FLAKES_DIR="/data/data/com.termux.nix/files/home/pick-up-nix2/submodule-flakes"
PROJECT_ROOT="/data/data/com.termux.nix/files/home/pick-up-nix2/source/github/meta-introspector/git-submodule-tools-rs"
GITMODULES_FILE="${PROJECT_ROOT}/.gitmodules"

# Function to update a single submodule's flake
update_single_submodule_flake() {
    local original_submodule_path="$1" # Path as in .gitmodules, e.g., vendor/cargo_metadata

    # Skip if original_submodule_path is empty
    if [[ -z "${original_submodule_path}" ]]; then
        echo "Skipping empty submodule path."
        return
    fi

    echo "DEBUG: original_submodule_path = ${original_submodule_path}"

    # Sanitize name for directory and package (same logic as in Python script)
    local submodule_name=$(echo "${original_submodule_path}" | sed 's|vendor/||' | sed 's|/|-|g')

    echo "DEBUG: submodule_name = ${submodule_name}"

    echo "Updating flake for submodule: ${submodule_name} (original path: ${original_submodule_path})"

    # Check if the submodule directory exists
    if [[ ! -d "${PROJECT_ROOT}/${original_submodule_path}" ]]; then
        echo "Error: Submodule directory ${PROJECT_ROOT}/${original_submodule_path} does not exist. Skipping."
        return
    fi

    # Get the current commit hash of the submodule
    local current_dir=$(pwd)
    cd "${PROJECT_ROOT}/${original_submodule_path}"
    local submodule_rev=$(git rev-parse HEAD)
    cd "${current_dir}"

    local flake_file="${SUBMODULE_FLAKES_DIR}/${submodule_name}/flake.nix"

    echo "DEBUG: flake_file = ${flake_file}"

    # Check if the flake file exists
    if [[ ! -f "${flake_file}" ]]; then
        echo "Error: Flake file ${flake_file} does not exist. Skipping."
        return
    fi

    # Update the rev in the flake.nix
    sed -i "s|rev = \"PUT_SUBMODULE_REV_HERE\";|rev = \"${submodule_rev}\";|" "${flake_file}"
    echo "Updated rev to ${submodule_rev} in ${flake_file}"

    # Attempt to build to get the sha256. This will fail if sha256 is incorrect, but will provide the correct one.
    echo "Attempting initial Nix build to get sha256 for ${submodule_name}..."
    # We need to run this from the project root where the flake.nix is located
    (cd "${SUBMODULE_FLAKES_DIR}/${submodule_name}" && nix build ".#${submodule_name}" || true)
}

# Read submodule paths from .gitmodules
# git config --file .gitmodules --get-regexp submodule..*.path
# Output format: submodule.<name>.path <path>
git config --file "${GITMODULES_FILE}" --get-regexp submodule..*.path | \
# grep "submodule..*.path" | \
while IFS=' ' read -r _ original_submodule_path; do
    update_single_submodule_flake "${original_submodule_path}"
done

echo "All submodule flakes updated with current revisions. Now run update_submodule_shas.sh to update sha256."
