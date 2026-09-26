# CRQ-002: Gemini CLI/Tmux Integration Scripts Refactoring

## 1. Problem Description

The Gemini CLI/Tmux integration scripts (`boot.sh`, `gemini_split.sh`, `run_boot.sh`, `single_gemini_split.sh`, `subtask.sh`, `test.sh`, `test2.sh`) suffer from:

*   Significant code duplication, particularly between `gemini_split.sh`, `subtask.sh`, and `single_gemini_split.sh`.
*   Inconsistent shebangs and missing `set -euo pipefail`.
*   Hardcoded paths and task file names.
*   Insufficient error handling for `tmux` commands and script calls.
*   Inconsistent logic for `GEMINI_INVOCATION`.

These issues lead to increased maintenance overhead, potential for bugs, and reduced readability.

## 2. Proposed Solution

Refactor these scripts to improve robustness, remove duplication, and enforce best practices. Key actions include:

*   **Modularization:** Extract common `tmux` operations and Gemini CLI invocation logic into reusable functions or a shared library script.
*   **DRY Principle:** Eliminate code duplication by sourcing shared functions or redesigning the script flow.
*   **Best Practices Adherence:** Apply all relevant best practices from `shell_script_best_practices.md`, including:
    *   Consistent shebang (`#!/usr/bin/env bash`).
    *   `set -euo pipefail`.
    *   Robust error handling for all commands, especially `tmux`.
    *   Parameterization of hardcoded values (e.g., `TASK_FILE`, `SESSION_NAME`).
    *   Consistent and clear `GEMINI_INVOCATION` logic.
*   **Consolidation (Optional):** Evaluate if `test.sh` and `test2.sh` can be absorbed into a more comprehensive testing framework or removed if redundant.

## 3. Scope

This CRQ applies to the following scripts:

*   `/data/data/com.termux.nix/files/home/pick-up-nix/boot.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/gemini_split.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/run_boot.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/single_gemini_split.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/subtask.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/test.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/test2.sh`

## 4. Expected Outcome

*   Reduced code duplication and improved maintainability.
*   More robust and reliable `tmux` and Gemini CLI interactions.
*   Enhanced readability and easier debugging.
*   Scripts adhere to project-wide shell scripting best practices.

## 5. Priority

**High** - Addressing these issues will significantly improve the core development workflow and reduce technical debt.

## 6. Dependencies

*   Familiarity with shell scripting best practices.
*   Understanding of `tmux` commands and Gemini CLI invocation.

## 7. Metrics for Success

*   Code duplication reduced by X% (to be measured).
*   All affected scripts pass linting checks (e.g., `shellcheck`).
*   Successful execution of all integration tests involving these scripts.
