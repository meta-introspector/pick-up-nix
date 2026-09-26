# CRQ-005: Enhanced Nix Integration for Shell Scripts

## 1. Problem Description

While the project utilizes Nix, some shell scripts do not fully leverage Nix capabilities for dependency management, environment setup, and deployment. This leads to:

*   Inconsistent environment setups (e.g., manual Python virtual environment management in `petals.sh`).
*   Potential for non-reproducible builds or deployments due to external dependencies not managed by Nix.
*   Reliance on `--impure` flags in Nix commands without clear justification.
*   Duplication of dependency management efforts.

## 2. Proposed Solution

Enhance the integration of Nix within shell scripts to improve reproducibility, consistency, and simplify dependency management.

*   **Nix for Environment Management:** Where applicable, replace manual environment setups (e.g., Python `virtualenv` and `pip install`) with Nix-managed environments. This can involve using `nix-shell`, `nix develop`, or defining specific Nix packages for script dependencies.
*   **Pure Builds:** Minimize the use of `--impure` flags in Nix commands. For any remaining `--impure` usage, provide clear documentation and justification.
*   **Nix for Tooling:** Ensure that external tools used by shell scripts (e.g., `nixpkgs-fmt`, `nix-linter`, `shellcheck`) are managed and provided via Nix, ensuring consistent versions across development environments and CI/CD.
*   **Nix for Deployment:** For remote deployments, explore using NixOps or similar Nix-native deployment tools to replace fragile shell scripts, ensuring atomic upgrades and rollbacks.

## 3. Scope

This CRQ applies to all shell scripts that manage dependencies, set up environments, or perform deployments, with a particular focus on:

*   `/data/data/com.termux.nix/files/home/pick-up-nix/petals.sh` (for Python environment management).
*   `/data/data/com.termux.nix/files/home/pick-up-nix/qa.d/01_nix_builds.sh` (for `--impure` usage).
*   `/data/data/com.termux.nix/files/home/pick-up-nix/qa.d/02_nix_linters.sh` (for tooling dependencies).
*   Remote management scripts (as part of CRQ-001, if NixOps is chosen).

## 4. Expected Outcome

*   Improved reproducibility of builds and deployments.
*   Consistent development and CI/CD environments.
*   Simplified dependency management for shell scripts.
*   Reduced reliance on `--impure` operations.
*   Leveraging Nix's strengths for project infrastructure.

## 5. Priority

**High** - This will significantly improve the project's core infrastructure and align with the project's Nix-centric approach.

## 6. Dependencies

*   Understanding of Nix packaging and environment management.
*   Decision on adopting NixOps or similar tools for deployment.

## 7. Metrics for Success

*   Reduction in the number of `--impure` flags used in shell scripts.
*   All external tools used by scripts are managed via Nix.
*   Python environments for relevant scripts are managed by Nix.
