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

PROJECT_ROOT="/data/data/com.termux.nix/files/home/pick-up-nix"
RUST_NIX_DIR="$PROJECT_ROOT/vendor/external/rust/src/tools/nix-dev-shell"

log "Inside pick-up-nix devShell."
log "Entering rust-nix devShell..."

cd "$RUST_NIX_DIR" || error "Failed to change directory to $RUST_NIX_DIR"

nix develop .#default --command /bin/bash "$PROJECT_ROOT/gemini_cli_entrypoint.sh"

log "Exiting rust-nix devShell."
