#!/bin/bash

# This script performs Nix builds for Android and PC configurations.

REPORT_FILE="$1" # Report file passed as argument
TOTAL_STATUS=0

echo "Starting Android build..." | tee -a "${REPORT_FILE}"
nix build .#nixOnDroidConfigurations.android.config.system.build.toplevel --system aarch64-linux --impure 2>&1 | tee -a "${REPORT_FILE}"
ANDROID_BUILD_STATUS=${PIPESTATUS[0]}
if [ "${ANDROID_BUILD_STATUS}" -eq 0 ]; then
    echo "Android build: SUCCESS" | tee -a "${REPORT_FILE}"
else
    echo "Android build: FAILED (Exit Code: ${ANDROID_BUILD_STATUS})" | tee -a "${REPORT_FILE}"
    TOTAL_STATUS=$((TOTAL_STATUS + ANDROID_BUILD_STATUS))
fi
echo "" | tee -a "${REPORT_FILE}"

echo "Starting PC build..." | tee -a "${REPORT_FILE}"
nix build .#nixosConfigurations.desktop.config.system.build.toplevel 2>&1 | tee -a "${REPORT_FILE}"
PC_BUILD_STATUS=${PIPESTATUS[0]}
if [ "${PC_BUILD_STATUS}" -eq 0 ]; then
    echo "PC build: SUCCESS" | tee -a "${REPORT_FILE}"
else
    echo "PC build: FAILED (Exit Code: ${PC_BUILD_STATUS})" | tee -a "${REPORT_FILE}"
    TOTAL_STATUS=$((TOTAL_STATUS + PC_BUILD_STATUS))
fi
echo "" | tee -a "${REPORT_FILE}"

exit ${TOTAL_STATUS}
