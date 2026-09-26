#!/bin/bash

# Define the report file
REPORT_FILE="/data/data/com.termux.nix/files/home/pick-up-nix/qa_build_report.txt"
OVERALL_STATUS=0

# Get current date and time
BUILD_DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo "--- QA Build Report - ${BUILD_DATE} ---" > "${REPORT_FILE}"
echo "" >> "${REPORT_FILE}"

# Iterate through scripts in qa.d/ and execute them
for script in qa.d/*.sh; do
    if [ -f "$script" ]; then
        echo "Executing QA script: $(basename "$script")" | tee -a "${REPORT_FILE}"
        bash "$script" "${REPORT_FILE}"
        SCRIPT_STATUS=$?
        if [ ${SCRIPT_STATUS} -ne 0 ]; then
            echo "Script $(basename "$script") FAILED (Exit Code: ${SCRIPT_STATUS})" | tee -a "${REPORT_FILE}"
            OVERALL_STATUS=$((OVERALL_STATUS + SCRIPT_STATUS))
        else
            echo "Script $(basename "$script") SUCCESS" | tee -a "${REPORT_FILE}"
        fi
        echo "" | tee -a "${REPORT_FILE}"
    fi
done

echo "QA build process completed. Report saved to ${REPORT_FILE}" | tee -a "${REPORT_FILE}"

exit ${OVERALL_STATUS}