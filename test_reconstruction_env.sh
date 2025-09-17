#!/usr/bin/env bash

# Function to log messages
log() {
  echo "[INFO] $1"
}

# Function to log errors
error() {
  echo "[ERROR] $1" >&2
}

# Navigate to the pick-up-nix directory
PROJECT_ROOT="/data/data/com.termux.nix/files/home/pick-up-nix"
cd "$PROJECT_ROOT" || error "Failed to change directory to $PROJECT_ROOT"

log "Attempting to enter the reconstructed Nix environment..."

# Use a subshell to enter the nix develop environment and run a test command
# This will not persist the environment in the current shell
if nix develop -f ./reconstruction.nix --command bash -c "
  echo \"--- Inside Reconstructed Environment ---\"
  echo \"Current working directory: $(pwd)\"
  echo \"Checking for 'gemini' command...\"
  if command -v gemini &> /dev/null; then
    echo \"'gemini' command found.\"
    # You can add more tests here, e.g., gemini --version
  else
    error \"'gemini' command NOT found.\"
  fi
  echo \"--- Exiting Reconstructed Environment ---\"
"; then
  log "Successfully entered and tested the reconstructed Nix environment."
else
  error "Failed to enter or test the reconstructed Nix environment. Please check the error messages above."
fi
