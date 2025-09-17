#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Enable verbose logging
set -x

# Capture all logs to a file
LOG_FILE="$(dirname "$0")/add_mkaiderivation_submodule.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Set a timeout for the script (e.g., 5 minutes)
TIMEOUT_SECONDS=300

# Function to handle timeouts
handle_timeout() {
    echo "Script timed out after $TIMEOUT_SECONDS seconds."
    exit 1
}

trap handle_timeout SIGINT SIGTERM

# Start the timeout in a subshell
( sleep "$TIMEOUT_SECONDS" && kill -SIGTERM $$ ) &
TIMEOUT_PID=$!

PROJECT_ROOT="/data/data/com.termux.nix/files/home/pick-up-nix2"
SUBMODULE_PATH="vendor/mkAIDerivation"
SUBMODULE_URL="https://github.com/meta-introspector/mkAIDerivation.git"

cd "$PROJECT_ROOT"

echo "Attempting to add submodule: $SUBMODULE_URL to $SUBMODULE_PATH"

# Check if the submodule path already exists in .gitmodules
if grep -q "[submodule \"$SUBMODULE_PATH\"]" .gitmodules; then
    echo "Submodule $SUBMODULE_PATH already exists in .gitmodules. Skipping 'git submodule add'."
else
    # Add the submodule
    git submodule add "$SUBMODULE_URL" "$SUBMODULE_PATH"
fi

# Initialize and update submodules
echo "Initializing and updating all submodules..."
git submodule update --init --recursive "$SUBMODULE_PATH"

# Verify the submodule status
echo "Verifying submodule status..."
git submodule status

# Commit changes if any
if ! git diff --quiet --exit-code .gitmodules "$SUBMODULE_PATH"; then
    echo "Committing changes..."
    git add .gitmodules "$SUBMODULE_PATH"
    git commit -m "feat: Add mkAIDerivation as a Git submodule"
else
    echo "No changes to commit for mkAIDerivation submodule."
fi

kill "$TIMEOUT_PID"
wait "$TIMEOUT_PID" 2>/dev/null || true

echo "Script finished successfully."