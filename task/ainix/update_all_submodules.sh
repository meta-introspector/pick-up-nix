#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Enable verbose logging
set -x

# Capture all logs to a file
LOG_FILE="$(dirname "$0")"/update_all_submodules.log
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

cd "$PROJECT_ROOT"

echo "Updating all submodules..."
git submodule update --init --recursive

# Verify the submodule status
echo "Verifying submodule status..."
git submodule status

kill "$TIMEOUT_PID"
wait "$TIMEOUT_PID" 2>/dev/null || true

echo "Script finished successfully."