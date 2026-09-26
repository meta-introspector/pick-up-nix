#!/bin/bash

JOB_SCRIPT="$1"

if [ -z "$JOB_SCRIPT" ]; then
  echo "Usage: $0 <job_script_path>"
  exit 1
fi

if [ ! -f "$JOB_SCRIPT" ]; then
  echo "Error: Job script '$JOB_SCRIPT' not found."
  exit 1
fi

# Check if we are inside a tmux session
if [ -z "$TMUX" ]; then
  echo "Error: This script must be run inside a tmux session."
  exit 1
fi

echo "Launching job script '$JOB_SCRIPT' in a new tmux split window..."

# Create a new vertical split pane
tmux split-window -v

# Send the job script command to the newly created pane
tmux send-keys "$JOB_SCRIPT" C-m

# Select the original pane (optional, but good for user experience)
tmux select-pane -t :.+1
