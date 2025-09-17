#!/usr/bin/env bash

# Script for batch processing of tasks using gemini-cli

# Function to log messages
log() {
  echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') $1"
}

# Function to log errors
error() {
  echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') $1" >&2
  exit 1
}

# Check if at least one task file is provided
if [ "$#" -eq 0 ]; then
  error "Usage: $0 <task_file1> [task_file2 ...]"
fi

log "Starting batch task processing..."

# Loop through each provided task file
for task_file in "$@"; do
  if [ -f "$task_file" ]; then
    log "Processing task file: $task_file"

    # Extract the base task file name (e.g., prompts/task_001_emacs_lisp.md)
    base_task_file=$(echo "$task_file" | sed -E 's/\.out.*//')

    if [ -f "$base_task_file" ]; then
      log "Consolidating output from '$task_file' into '$base_task_file'"
      echo "\n\n--- Output from $task_file ---\n" >> "$base_task_file"
      cat "$task_file" >> "$base_task_file"
      log "Deleting processed output file: $task_file"
      rm "$task_file"
    else
      error "Base task file '$base_task_file' not found for '$task_file'. Skipping consolidation."
    fi
  else
    log "Warning: Task file not found, skipping: $task_file"
  fi
done

log "Batch task processing completed."
