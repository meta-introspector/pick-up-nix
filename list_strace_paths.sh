#!/bin/bash

LOG_FILE="/data/data/com.termux.nix/files/home/pick-up-nix/data/2025/09/09/001/strace1.log"

echo "Extracting unique Nix store paths from $LOG_FILE..."

# Extract unique Nix store paths from strace log
# Nix store paths typically start with /nix/store/ followed by a 32-character hash.
grep -oE '/nix/store/[a-z0-9]{32}-[^"]+' "$LOG_FILE" | sort -u