#!/usr/bin/env bash

# SOP: Standard Operating Procedure for Generating Nix Flake Dependency Graph

# Purpose: This script automates the generation of a dependency graph for a Nix flake
# using the 'nixtract' tool. The output is saved in JSONL format.

# Usage:
#   ./generate_nix_graph.sh [FLAKE_PATH]
#   If FLAKE_PATH is not provided, the current working directory is used.

# Output:
#   A file named 'derivations.jsonl' will be created in the directory where the script is run,
#   containing the dependency graph in JSONL format.

FLAKE_PATH=${1:-$(pwd)}
OUTPUT_FILE="derivations.jsonl"

echo "Generating Nix flake dependency graph for: $FLAKE_PATH"
echo "Output will be saved to: $OUTPUT_FILE"

if nix run github:tweag/nixtract -- --target-flake-ref "$FLAKE_PATH" > "$OUTPUT_FILE"; then
    echo "Successfully generated dependency graph to $OUTPUT_FILE"
else
    echo "Error: Failed to generate dependency graph."
    echo "Please check the output above for details."
    exit 1
fi
