# CRQ-006: Cleanup of Old Cruft and Unused Code

## 1. Problem Description

Several shell scripts contain excessive commented-out code, unused sections, and potentially redundant files. This "old cruft" leads to:

*   Reduced readability and increased cognitive load for developers.
*   Difficulty in understanding the active functionality of scripts.
*   Maintenance overhead for code that is no longer actively used.
*   Clutter in the codebase.

## 2. Proposed Solution

Systematically identify and remove all commented-out code, unused sections, and redundant scripts. If historical context is needed for removed code, it should be accessible via version control history or moved to dedicated documentation.

*   **Remove Commented-Out Code:** Delete large blocks of commented-out code from scripts. The Git history serves as the primary record for past iterations.
*   **Identify and Remove Unused Scripts:** Review all shell scripts to determine if they are still actively used or if their functionality has been superseded. Remove any identified unused scripts.
*   **Consolidate Redundant Functionality:** If multiple scripts perform very similar tasks, consolidate them into a single, parameterized script.

## 3. Scope

This CRQ applies to all shell scripts within the project, with a particular focus on those identified in `script_review_findings.md` as having excessive commented-out code (e.g., `gettargets.sh`, `install_nagios.sh`, `petals.sh`).

## 4. Expected Outcome

*   Improved readability and maintainability of shell scripts.
*   Reduced codebase size and complexity.
*   Clearer understanding of active script functionality.
*   Reduced technical debt.

## 5. Priority

**Medium** - While not directly impacting functionality, addressing cruft significantly improves developer experience and long-term maintainability.

## 6. Dependencies

*   Thorough understanding of each script's current purpose.
*   Reliance on Git history for historical context.

## 7. Metrics for Success

*   Significant reduction in lines of commented-out code across the codebase.
*   Removal of identified unused scripts.
*   Positive feedback from developers regarding script readability.
