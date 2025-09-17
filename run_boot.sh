#!/usr/bin/env bash

SESSION_NAME="$2"

TASK_FILE="task.md" # Placeholder for the task file


# Determine Gemini CLI invocation method (bunx or npx)
#GEMINI_INVOCATION="npx @google/gemini-cli"
#if command -v bun &> /dev/null;
#then
#  GEMINI_INVOCATION="bunx @google/gemini-cli"
#fi
GEMINI_INVOCATION="gemini"
# Start or attach to a tmux session
# If the session doesn't exist, it will create it and run the gemini command
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Starting new tmux session: $SESSION_NAME"
  tmux new-session -d -s "$SESSION_NAME"

  # Send commands to the new tmux session
  # Incorporating best practices: --all-files, --approval-mode default, --checkpointing
  # Using --prompt-interactive to continue the session after loading the task file
  tmux send-keys -t "$SESSION_NAME" "echo 'Welcome to the Gemini Development Session!'" C-m
  tmux send-keys -t "$SESSION_NAME" "echo 'Loading task from $TASK_FILE...'" C-m
  tmux send-keys -t "$SESSION_NAME" "$GEMINI_INVOCATION --model=gemini-2.5-flash --approval-mode default --checkpointing --prompt-interactive \"@$TASK_FILE\"" C-m
else
  echo "Attaching to existing tmux session: $SESSION_NAME"
fi

# Attach to the tmux session
tmux attach-session -t "$SESSION_NAME"

# When tmux session exits, stop asciinema recording
echo "Tmux session exited. Stopping asciinema recording..."
# The PID is passed from boot.sh, so we don't need to kill it here.
# The asciinema process is managed by boot.sh
echo "Asciinema recording stopped."
