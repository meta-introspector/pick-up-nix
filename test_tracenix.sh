#!/bin/bash

set -euo pipefail

# Define the command to test
TRACENIX_CMD="cargo run -- tracenix --"

# Define a simple nix command to trace
NIX_TEST_ARGS="--version"

echo "Running tracenix with arguments: ${NIX_TEST_ARGS}"

# Execute tracenix and capture output
OUTPUT=$(${TRACENIX_CMD} ${NIX_TEST_ARGS} 2>&1)
EXIT_CODE=$?

printf "\n--- tracenix Output ---\n"
echo "${OUTPUT}"
echo "--- Exit Code: ${EXIT_CODE} ---"

# Basic validation
if [ ${EXIT_CODE} -eq 0 ]; then
    echo "Test Passed: tracenix exited successfully."
    # Further checks: look for specific output patterns
    if echo "${OUTPUT}" | grep -q "Captured [0-9]\+ system events."; then
        echo "Test Passed: Detected system events capture message."
    else
        echo "Test Failed: Did not detect system events capture message."
        exit 1
    fi
else
    echo "Test Failed: tracenix exited with an error."
    exit 1
fi

printf "\nAll tracenix tests completed.\n"
