#!/usr/bin/env bash

# This script commits all changes in the Git repository without running git status.
# It is designed for situations where git status is slow and all changes need to be committed.

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the commit message
COMMIT_MESSAGE="Update task.md, clean up prompts, consolidate CRQs and Cargo.toml tasks, and initiate podcast generator task."

echo "Adding all changes to the staging area..."
git add -A

echo "Committing changes with message: \"${COMMIT_MESSAGE}\""
git commit -m "${COMMIT_MESSAGE}"

echo "All changes committed successfully."
