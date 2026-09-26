#!/bin/bash

LOG_FILE="/data/data/com.termux.nix/files/home/pick-up-nix/data/2025/09/09/001/strace1.log"
TARGET_DIR="/data/data/com.termux.nix/files/home/pick-up-nix/data/2025/09/09/001/extracted_files"

mkdir -p "$TARGET_DIR"

echo "Extracting paths from $LOG_FILE and copying to $TARGET_DIR..."

# Extract unique absolute paths from strace log
# This pattern looks for paths within openat, statx, etc. calls
# It's a basic attempt and might need refinement for complex strace outputs.
grep -oE '"/[^"]+"' "$LOG_FILE" | sed 's/"//g' | sort -u | while read -r FILE_PATH; do
    # Check if the file exists and is a regular file
    if [ -f "$FILE_PATH" ]; then
        # Copy the file, preserving its base name
        cp "$FILE_PATH" "$TARGET_DIR/"
        echo "Copied: $FILE_PATH"
    elif [ -d "$FILE_PATH" ]; then
        echo "Skipping directory: $FILE_PATH"
    else
        echo "Skipping non-existent or special file: $FILE_PATH"
    fi
done

echo "Extraction complete."
echo "Note: This script copies files directly into the target directory. It does not preserve the original directory structure from the Nix store."
