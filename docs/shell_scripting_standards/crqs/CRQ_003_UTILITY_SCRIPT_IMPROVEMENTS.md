# CRQ-003: Utility and Other Scripts Improvements

## 1. Problem Description

The utility and miscellaneous scripts (`build_and_report.sh`, `tweet-confirmation.sh`, `tweet_tool.sh`, `vendor/rust-index-guix/update.sh`, `shell.sh`, `runtests.sh`) are generally functional but exhibit inconsistencies and areas for improvement:

*   Inconsistent shebangs and missing `set -euo pipefail`.
*   Some hardcoded paths (e.g., in `shell.sh`).
*   Opportunities for more robust error handling.
*   Code duplication (e.g., `runtests.sh` and `qa.d/01_nix_builds.sh`).
*   Scripts marked as "temporary solutions" indicate planned future refactoring.

## 2. Proposed Solution

Apply consistent shell scripting best practices to these scripts to improve their maintainability, reliability, and readability. Key actions include:

*   **Best Practices Adherence:** Apply all relevant best practices from `shell_script_best_practices.md`, including:
    *   Consistent shebang (`#!/usr/bin/env bash`).
    *   `set -euo pipefail`.
    *   Robust error handling for all commands.
    *   Minimizing hardcoded paths.
*   **Refactor Duplication:** Consolidate redundant logic (e.g., between `runtests.sh` and `qa.d/01_nix_builds.sh`) into shared functions or a single, parameterized script.
*   **Address "Temporary Solutions":** Prioritize the refactoring or replacement of scripts explicitly marked as temporary solutions if their Rust replacements are not imminent.

## 3. Scope

This CRQ applies to the following scripts:

*   `/data/data/com.termux.nix/files/home/pick-up-nix/build_and_report.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/tweet-confirmation.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/tweet_tool.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/vendor/rust-index-guix/update.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/shell.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/runtests.sh`

## 4. Expected Outcome

*   Improved maintainability and reliability of utility scripts.
*   Reduced technical debt associated with "temporary solutions."
*   Consistent application of shell scripting best practices across the project.

## 5. Priority

**Medium** - These improvements will enhance overall code quality and reduce future maintenance burden.

## 6. Dependencies

*   Familiarity with shell scripting best practices.

## 7. Metrics for Success

*   All affected scripts pass linting checks (e.g., `shellcheck`).
*   Reduced instances of hardcoded paths.
*   Elimination of identified code duplication.
