#!/usr/bin/env bash

set -euo pipefail

SUBMODULE_FLAKES_DIR="/data/data/com.termux.nix/files/home/pick-up-nix2/submodule-flakes"

# Function to update sha256 for a single submodule's flake
update_single_submodule_sha() {
    local submodule_name="$1"

    local flake_file="${SUBMODULE_FLAKES_DIR}/${submodule_name}/flake.nix"

    echo "Updating sha256 for submodule: ${submodule_name}"

    # Run nix build and capture stderr to find the correct sha256
    # We expect it to fail and provide the correct hash in the error message
    local nix_build_output
    # Corrected: Use --flake argument with the absolute path to the flake file
    nix_build_output=$(nix build --flake "${flake_file}#packages.x86_64-linux.${submodule_name}" 2>&1 || true)

    echo "DEBUG: nix_build_output for ${submodule_name}:\n${nix_build_output}" # Added debug print

    local correct_sha256
    correct_sha256=$(echo "${nix_build_output}" | grep "got:" | sed -E 's/.*got:\s+sha256-(.*)/\1/')

    if [[ -n "${correct_sha256}" ]]; then
        echo "Found correct sha256: ${correct_sha256}"
        # Update the sha256 in the flake.nix
        sed -i "s|sha256 = \"PUT_SUBMODULE_SHA256_HERE\";|sha256 = \"${correct_sha256}\";|" "${flake_file}"
        echo "Updated sha256 in ${flake_file}"
    else
        echo "Warning: Could not find correct sha256 for ${submodule_name}. Check nix build output manually."
        echo "${nix_build_output}"
        exit 1 # Exit with error if sha256 not found, to stop further processing and allow debugging
    fi
}

# Iterate through each submodule flake directory
for submodule_flake_dir in "${SUBMODULE_FLAKES_DIR}"/*/;
do
    if [[ -d "${submodule_flake_dir}" ]]; then
        submodule_name=$(basename "${submodule_flake_dir}")
        update_single_submodule_sha "${submodule_name}"
    fi
done

echo "All submodule flakes updated with correct sha256 hashes."