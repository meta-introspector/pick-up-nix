#!/bin/bash

# Function to encapsulate subtask.sh logic
# Arguments: $1 = JOB_COMMAND
run_in_tmux_split() {
  local JOB_COMMAND="$1"

  if [ -z "$JOB_COMMAND" ]; then
    echo "Error: No command provided to run_in_tmux_split."
    exit 1
  fi

  # Check if we are inside a tmux session
  if [ -z "$TMUX" ]; then
    echo "Error: This script must be run inside a tmux session."
    exit 1
  fi

  echo "Launching command '$JOB_COMMAND' in a new tmux split window..."

  # Create a new vertical split pane
  tmux split-window -v

  # Send the job command to the newly created pane, ensuring it's treated as a single command
  tmux send-keys "$JOB_COMMAND" C-m

  # Select the original pane (optional, but good for user experience)
  tmux select-pane -t :.+1
}

# Function to encapsulate gemini_split.sh logic
# Arguments: $1 = TASK_FILE
launch_gemini_in_split() {
  local TASK_FILE="$1"

  if [ -z "$TASK_FILE" ]; then
    echo "Error: No task file provided to launch_gemini_in_split."
    exit 1
  fi

  if [ ! -f "$TASK_FILE" ]; then
    echo "Error: Task file '$TASK_FILE' not found."
    exit 1
  fi

  # Determine Gemini CLI invocation method (bunx or npx)
  local GEMINI_INVOCATION="gemini"
  if command -v bun &> /dev/null; then
    GEMINI_INVOCATION="bunx @google/gemini-cli"
  elif command -v npx &> /dev/null; then
    GEMINI_INVOCATION="npx @google/gemini-cli"
  fi

  # Construct the full Gemini command
  # Using --prompt-interactive to continue the session after loading the task file
  local GEMINI_COMMAND="$GEMINI_INVOCATION --model=gemini-2.5-flash --prompt-interactive \"@$TASK_FILE\""

  # Call the run_in_tmux_split function
  run_in_tmux_split "$GEMINI_COMMAND"
}

# Main execution part (from test.sh)
# Call launch_gemini_in_split with the specific task file
launch_gemini_in_split "poetry_task.md"
