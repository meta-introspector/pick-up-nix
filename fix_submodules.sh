#!/usr/bin/env bash

# Function to log messages
log() {
  echo "[INFO] $1"
}

# Function to log errors
error() {
  echo "[ERROR] $1" >&2
  exit 1
}

# List of submodules with issues (from submodule_issues.txt)
SUBMODULE_PATHS=(
  "source/github/meta-introspector/hackathon"
  "source/github/meta-introspector/streamofrandom"
  "source/github/meta-introspector/submodules"
  "source/github/meta-introspector/time"
  "vendor/external/gemini-cli"
  "vendor/external/github-issues-export-rs"
  "vendor/external/rust"
  "vendor/nix/nixtract"
  "vendor/strace/rstrace"
)

ORIGINAL_DIR=$(pwd)

log "Initial git status of superproject (ignoring submodules):"
git status --ignore-submodules

for SUBMODULE_PATH in "${SUBMODULE_PATHS[@]}"; do
  log "Processing submodule: $SUBMODULE_PATH"
  if [ -d "$SUBMODULE_PATH" ]; then
    cd "$SUBMODULE_PATH" || error "Failed to change directory to $SUBMODULE_PATH"

    log "Git status of $SUBMODULE_PATH before processing:"
    git status

    # Check if there are any changes to commit within the submodule
    if ! git diff --quiet || ! git diff --quiet --cached; then
      log "Staging changes in $SUBMODULE_PATH..."
      git add . || error "Failed to add changes in $SUBMODULE_PATH"
      log "Committing changes in $SUBMODULE_PATH..."
      git commit -m "Update submodule content" || log "No changes to commit in $SUBMODULE_PATH"
    else
      log "No changes to commit in $SUBMODULE_PATH."
    fi

    # Check for untracked files and add them
    if [ -n "$(git status --porcelain)" ]; then
      log "Untracked files found in $SUBMODULE_PATH. Staging and committing..."
      git add . || error "Failed to add untracked files in $SUBMODULE_PATH"
      git commit -m "Add untracked files in submodule" || log "No untracked files to commit in $SUBMODULE_PATH"
    fi

    log "Git status of $SUBMODULE_PATH after processing:"
    git status

    cd "$ORIGINAL_DIR" || error "Failed to change back to original directory"
  else
    log "Submodule path does not exist: $SUBMODULE_PATH. Skipping."
  fi
done

log "Finished processing all specified submodules."

log "Final git status of superproject (ignoring submodules):"
git status --ignore-submodules

log "Submodule fix script finished."
