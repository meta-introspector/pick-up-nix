#!/bin/bash

# This script performs Nix formatting and linting checks.

REPORT_FILE="$1" # Report file passed as argument
TOTAL_STATUS=0

echo "Starting Nix formatting check (nixpkgs-fmt)..." | tee -a "${REPORT_FILE}"
nixpkgs-fmt --check . 2>&1 | tee -a "${REPORT_FILE}"
NIXPKGS_FMT_STATUS=${PIPESTATUS[0]}
if [ "${NIXPKGS_FMT_STATUS}" -eq 0 ]; then
    echo "nixpkgs-fmt: SUCCESS" | tee -a "${REPORT_FILE}"
else
    echo "nixpkgs-fmt: FAILED (Exit Code: ${NIXPKGS_FMT_STATUS})" | tee -a "${REPORT_FILE}"
    TOTAL_STATUS=$((TOTAL_STATUS + NIXPKGS_FMT_STATUS))
fi
echo "" | tee -a "${REPORT_FILE}"

echo "Starting Nix linting check (nix-linter)..." | tee -a "${REPORT_FILE}"
nix-linter . 2>&1 | tee -a "${REPORT_FILE}"
NIX_LINTER_STATUS=${PIPESTATUS[0]}
if [ "${NIX_LINTER_STATUS}" -eq 0 ]; then
    echo "nix-linter: SUCCESS" | tee -a "${REPORT_FILE}"
else
    echo "nix-linter: FAILED (Exit Code: ${NIX_LINTER_STATUS})" | tee -a "${REPORT_FILE}"
    TOTAL_STATUS=$((TOTAL_STATUS + NIX_LINTER_STATUS))
fi
echo "" | tee -a "${REPORT_FILE}"

exit ${TOTAL_STATUS}
