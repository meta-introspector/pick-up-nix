#!/usr/bin/env bash
set -euo pipefail

# This script iterates through provisional flake files, builds them,
# and applies the QA process to each.

MANIFEST_FILE="manifests/provisional_flake_files.json"
LOG_DIR="${HOME}/logs/provisional_flake_qa"
mkdir -p "${LOG_DIR}"

REPORT_FILE="${LOG_DIR}/provisional_flake_qa_summary_$(date +"%Y%m%d_%H%M%S").txt"

echo "--- Provisional Flake QA Process Started ---" | tee "${REPORT_FILE}"
echo "Summary Report: ${REPORT_FILE}" | tee -a "${REPORT_FILE}"
echo "" | tee -a "${REPORT_FILE}"

# Read flake paths from the manifest
FLAKE_PATHS=$(jq -r '.[]' "${MANIFEST_FILE}")

OVERALL_QA_STATUS=0
FLAKES_PROCESSED=0
FLAKES_FAILED=0

for FLAKE_PATH_RELATIVE in ${FLAKE_PATHS}; do
    FLAKES_PROCESSED=$((FLAKES_PROCESSED + 1))
    echo "--- Processing Flake: ${FLAKE_PATH_RELATIVE} ---" | tee -a "${REPORT_FILE}"

    # Determine the flake's root directory
    # If it's a flake.nix, the root is its directory. If it's flake.lock, it's its directory.
    FLAKE_ROOT_DIR=$(dirname "${FLAKE_PATH_RELATIVE}")
    if [[ "${FLAKE_ROOT_DIR}" == "." ]]; then
        FLAKE_ROOT_DIR=$(pwd) # If it's in the current directory, use pwd
    else
        FLAKE_ROOT_DIR="$(pwd)/${FLAKE_ROOT_DIR}" # Make it absolute
    fi

    FLAKE_LOG_FILE="${LOG_DIR}/$(basename "${FLAKE_ROOT_DIR}")_$(date +"%Y%m%d_%H%M%S").log"
    echo "  Detailed Log: ${FLAKE_LOG_FILE}" | tee -a "${REPORT_FILE}"

    # Change to the flake's root directory, run QA, then change back
    ( # Use a subshell to contain the cd command
        cd "${FLAKE_ROOT_DIR}" || { echo "Error: Could not change to ${FLAKE_ROOT_DIR}" | tee -a "${REPORT_FILE}"; exit 1; }
        echo "  Running QA process in: $(pwd)" | tee -a "${REPORT_FILE}"
        # Call build_qa_process.sh with its parameters
        # We can pass optional parameters for timeout, strace, verbose here if needed
        bash /data/data/com.termux.nix/files/home/pick-up-nix/build_qa_process.sh "${FLAKE_LOG_FILE}"
        )
    FLAKE_QA_STATUS=$? # Capture the exit code of the subshell
    
    if [ "${FLAKE_QA_STATUS}" -ne 0 ]; then
        echo "  Status: FAILED (Exit Code: ${FLAKE_QA_STATUS})" | tee -a "${REPORT_FILE}"
        FLAKES_FAILED=$((FLAKES_FAILED + 1))
        OVERALL_QA_STATUS=1 # Set overall status to failure if any flake fails
    else
        echo "  Status: SUCCESS" | tee -a "${REPORT_FILE}"
    fi
    echo "" | tee -a "${REPORT_FILE}"
done

echo "--- Provisional Flake QA Process Completed ---" | tee -a "${REPORT_FILE}"
echo "Total Flakes Processed: ${FLAKES_PROCESSED}" | tee -a "${REPORT_FILE}"
echo "Total Flakes Failed: ${FLAKES_FAILED}" | tee -a "${REPORT_FILE}"

exit ${OVERALL_QA_STATUS}
