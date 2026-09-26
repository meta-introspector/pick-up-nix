#!/usr/bin/env bash
set -euo pipefail

# This script orchestrates the build and QA process, logging all output.

LOG_FILE="$1" # Log file path passed as argument
TIMEOUT_DURATION="${2:-3600}" # Default to 1 hour (3600 seconds)
STRACE_ENABLED="${3:-false}" # Default to false
VERBOSE_MODE="${4:-false}" # Default to false

BUILD_START_TIME=$(date +"%Y-%m-%d %H:%M:%S")
OVERALL_STATUS=0

# Function to log messages
log_message() {
  local type="$1"
  local message="$2"
  if [[ "${type}" == "DEBUG" && "${VERBOSE_MODE}" == "false" ]]; then
    return # Skip debug messages if verbose mode is off
  fi
  echo "$(date +"%Y-%m-%d %H:%M:%S") [${type}] ${message}" | tee -a "${LOG_FILE}"
}

# Function to execute commands with optional strace and timeout
execute_command() {
  local cmd_description="$1"
  local cmd_to_run="$2"
  local strace_log=""
  local full_cmd=""

  log_message INFO "Executing: ${cmd_description}"
  log_message DEBUG "Command: ${cmd_to_run}"

  if [[ "${STRACE_ENABLED}" == "true" ]]; then
    strace_log="${LOG_FILE%.*}_strace_$(echo "${cmd_description}" | tr ' ' '_' | tr -cd '[:alnum:]_').log"
    full_cmd="strace -o \"${strace_log}\" ${cmd_to_run}"
    log_message DEBUG "Strace log: ${strace_log}"
  else
    full_cmd="${cmd_to_run}"
  fi

  # Apply timeout to the full command
  if ! timeout -s TERM "${TIMEOUT_DURATION}" bash -c "${full_cmd}" 2>&1 | tee -a "${LOG_FILE}"; then
    local exit_code=${PIPESTATUS[0]}
    if [[ ${exit_code} -eq 124 ]]; then
      log_message ERROR "${cmd_description} TIMED OUT after ${TIMEOUT_DURATION} seconds."
    else
      log_message ERROR "${cmd_description} FAILED (Exit Code: ${exit_code})"
    fi
    return "${exit_code}"
  else
    log_message INFO "${cmd_description} SUCCESS"
    return 0
  fi
}


log_message INFO "--- QA Build Process Started - ${BUILD_START_TIME} ---"
log_message INFO "Log file: ${LOG_FILE}"
log_message INFO "Timeout duration: ${TIMEOUT_DURATION}s"
log_message INFO "Strace enabled: ${STRACE_ENABLED}"
log_message INFO "Verbose mode: ${VERBOSE_MODE}"

# --- Step 1: Run Nix QA Builds ---
execute_command "Nix QA Builds" "bash qa.d/01_nix_builds.sh \"${LOG_FILE}\""
NIX_BUILDS_STATUS=$?
OVERALL_STATUS=$((OVERALL_STATUS + NIX_BUILDS_STATUS))

# --- Step 2: Run Nix Linters ---
log_message INFO "Running Nix Linters..."

execute_command "nixpkgs-fmt" "nixpkgs-fmt --check ."
NIXPKGS_FMT_STATUS=$?
OVERALL_STATUS=$((OVERALL_STATUS + NIXPKGS_FMT_STATUS))

execute_command "Vendored nixpkgs-lint" "nix run .#nixpkgs-lint -- --check ."
NIXPKGS_LINT_STATUS=$?
OVERALL_STATUS=$((OVERALL_STATUS + NIXPKGS_LINT_STATUS))

# --- Step 3: Run Vendored nixtract (graph generation) ---
execute_command "Nix dependency graph generation" "bash generate_nix_graph.sh \"$(pwd)\""
NIX_GRAPH_STATUS=$?
OVERALL_STATUS=$((OVERALL_STATUS + NIX_GRAPH_STATUS))

# --- Step X: Add other QA steps as needed ---
# Example:
# execute_command "Other tests" "bash runtests.sh"
# OTHER_TESTS_STATUS=$?
# OVERALL_STATUS=$((OVERALL_STATUS + OTHER_TESTS_STATUS))

BUILD_END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
log_message INFO "--- QA Build Process Completed - ${BUILD_END_TIME} ---"
log_message INFO "Overall Status: ${OVERALL_STATUS}"

exit ${OVERALL_STATUS}