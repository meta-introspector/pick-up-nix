# CRQ-001: Remote Management Scripts Overhaul

## 1. Problem Description

The existing remote management shell scripts (`gettargets.sh`, `install_nagios.sh`, `install_service2.sh`, `install_service3.sh`, `petals.sh`) are highly problematic. They exhibit a severe lack of best practices, including:

*   Missing shebangs and `set -euo pipefail`.
*   Extensive use of hardcoded hostnames and paths.
*   Absence of robust error handling.
*   Lack of idempotency.
*   Reliance on undocumented aliases (`ssha`).
*   Excessive commented-out code.
*   Significant security risks due to direct `sudo` calls and unverified remote commands.

These issues make the scripts fragile, difficult to maintain, prone to silent failures, and potentially insecure. They pose the highest risk to project stability and security.

## 2. Proposed Solution

Completely overhaul or replace the existing remote management scripts. Recommended approaches include:

*   **Option A (Recommended): Adopt a Configuration Management Tool:** Implement a dedicated configuration management system (e.g., Ansible, NixOps) to manage remote deployments. This provides built-in idempotency, error handling, security features, and better scalability.
*   **Option B (If Option A is not feasible): Rewrite Scripts with Strict Best Practices:** If a configuration management tool cannot be adopted, rewrite each script from scratch, strictly adhering to all shell scripting best practices outlined in `shell_script_best_practices.md`. This includes:
    *   Consistent shebang (`#!/usr/bin/env bash`).
    *   `set -euo pipefail` at the beginning of every script.
    *   Robust error handling for every command.
    *   Elimination of hardcoded paths and hostnames (use configuration files, arguments, or dynamic discovery).
    *   Implementation of idempotency checks.
    *   Clear and consistent logging.
    *   Secure handling of credentials and `sudo` commands.
    *   Removal of all commented-out code.

## 3. Scope

This CRQ applies to the following scripts:

*   `/data/data/com.termux.nix/files/home/pick-up-nix/gettargets.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/install_nagios.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/install_service2.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/install_service3.sh`
*   `/data/data/com.termux.nix/files/home/pick-up-nix/petals.sh`

## 4. Expected Outcome

*   Remote deployments become reliable, reproducible, and secure.
*   Reduced risk of silent failures and unintended side effects.
*   Improved maintainability and readability of remote management code.
*   Enhanced project security posture.

## 5. Priority

**Critical** - This is the highest priority due to the severe impact on stability, security, and maintainability.

## 6. Dependencies

*   Decision on adopting a configuration management tool (if Option A is chosen).
*   Familiarity with shell scripting best practices (if Option B is chosen).

## 7. Metrics for Success

*   All affected scripts adhere to `shell_script_best_practices.md`.
*   Successful, idempotent execution of remote operations in various test environments.
*   Reduced number of incidents related to remote deployments.
