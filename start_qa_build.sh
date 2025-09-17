#!/usr/bin/env bash
set -euo pipefail

# This script starts the QA build process in the background.

LOG_DIR="${HOME}/logs/qa_build"
mkdir -p "${LOG_DIR}"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="${LOG_DIR}/qa_build_${TIMESTAMP}.log"

# Optional arguments for build_qa_process.sh
TIMEOUT_DURATION="${1:-3600}" # Default to 1 hour
STRACE_ENABLED="${2:-false}" # Default to false
VERBOSE_MODE="${3:-false}" # Default to false

echo "Starting QA build process in the background..."
echo "Log file: ${LOG_FILE}"
echo "Timeout duration: ${TIMEOUT_DURATION}s"
echo "Strace enabled: ${STRACE_ENABLED}"
echo "Verbose mode: ${VERBOSE_MODE}"
echo ""
echo "To view the live output, run: tail -f ${LOG_FILE}"
echo "To stop the process, find its PID (e.g., ps aux | grep build_qa_process.sh) and kill it."

# Run build_qa_process.sh in the background using nohup
nohup bash build_qa_process.sh "${LOG_FILE}" "${TIMEOUT_DURATION}" "${STRACE_ENABLED}" "${VERBOSE_MODE}" > /dev/null 2>&1 &

echo "QA build process started with PID: $!"
