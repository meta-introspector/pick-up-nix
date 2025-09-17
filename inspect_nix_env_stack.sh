#!/usr/bin/env bash

# Function to extract a specific environment variable from /proc/<pid>/environ
get_env_var() {
  local pid=$1
  local var_name=$2
  # Read /proc/<pid>/environ, replace nulls with newlines, and grep for the variable
  tr '\0' '\n' < "/proc/$pid/environ" | grep "^${var_name}=" | head -n 1
}

# Function to find the flake.nix by searching upwards from a directory
find_flake_root() {
  local start_dir=$1
  local current_dir=$start_dir
  while [ "$current_dir" != "/" ]; do
    if [ -f "$current_dir/flake.nix" ]; then
      echo "$current_dir"
      return 0
    fi
    current_dir=$(dirname "$current_dir")
  done
  echo "N/A"
  return 1
}

# Get the current shell's PID
CURRENT_PID=$$ 

echo "--- Nix Environment Stack Inspection ---"
echo "Starting from current PID: $CURRENT_PID"
echo ""

current_pid_in_loop=$CURRENT_PID
while [ "$current_pid_in_loop" -ne 1 ] && [ -d "/proc/$current_pid_in_loop" ]; do
  COMM=$(ps -p "$current_pid_in_loop" -o comm= 2>/dev/null | tr -d ' ')
  parent_pid=$(ps -o ppid= -p "$current_pid_in_loop" 2>/dev/null | tr -d ' ')
  CWD=$(readlink -f "/proc/$current_pid_in_loop/cwd" 2>/dev/null || echo "N/A")

  echo "PID: $current_pid_in_loop"
  echo "  Command: ${COMM:-N/A}"
  echo "  PPID: ${parent_pid:-N/A}"
  echo "  CWD: $CWD"

  # Extract relevant Nix environment variables
  IN_NIX_SHELL=$(get_env_var "$current_pid_in_loop" "IN_NIX_SHELL")
  NIX_PROFILES=$(get_env_var "$current_pid_in_loop" "NIX_PROFILES")
  NIX_FLAKE_DIR=$(get_env_var "$current_pid_in_loop" "NIX_FLAKE_DIR")
  NIX_BUILD_TOP=$(get_env_var "$current_pid_in_loop" "NIX_BUILD_TOP")
  PATH_VAR=$(get_env_var "$current_pid_in_loop" "PATH")

  if [ -n "$IN_NIX_SHELL" ]; then
    echo "  $IN_NIX_SHELL"
  fi
  if [ -n "$NIX_PROFILES" ]; then
    echo "  $NIX_PROFILES"
  fi
  if [ -n "$NIX_FLAKE_DIR" ]; then
    echo "  $NIX_FLAKE_DIR"
  fi
  if [ -n "$NIX_BUILD_TOP" ]; then
    echo "  $NIX_BUILD_TOP"
  fi
  if [ -n "$PATH_VAR" ]; then
    echo "  PATH (excerpt): ${PATH_VAR:0:100}..."
  fi

  # Attempt to find flake.nix root
  if [ "$CWD" != "N/A" ]; then
    FLAKE_ROOT=$(find_flake_root "$CWD")
    echo "  Potential Flake Root (from CWD): $FLAKE_ROOT"
  fi

  echo ""

  if ! [[ "$parent_pid" =~ ^[0-9]+$ ]]; then
    echo "Could not determine valid parent PID for process $current_pid_in_loop. Stopping."
    break
  fi
  current_pid_in_loop=$parent_pid
done

echo "--- End of Stack Inspection ---"