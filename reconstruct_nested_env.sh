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

log "Entering pick-up-nix devShell..."

nix develop "$PROJECT_ROOT"#default --command /bin/bash "$PROJECT_ROOT/rust_nix_entrypoint.sh"

log "Nested environment reconstruction script finished."
