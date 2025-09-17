# Glossary of Terms

This glossary defines key terms used within the Pick-Up-Nix project documentation, particularly related to shell scripting, Nix, and Git.

## A

## B
*   **Bare Git Repository:** A Git repository that does not have a working directory. It's typically used as a central repository for sharing changes.

## C
*   **CRQs (Change Requests/Requirements):** Specific, actionable items for refactoring, improving, and standardizing shell scripts.
*   **Commit Hash (SHA-1):** A unique identifier for a specific commit in a Git repository, used to pin submodules or sources to an exact version for reproducibility.
*   **Consistent Quoting:** Always double-quoting variables and command substitutions (`"$VAR"`, `"$(command)"`) to prevent unexpected behavior like globbing and word splitting.

## D
*   **Dependency Graph:** A visual representation of the relationships between components in a system, showing how they depend on each other. In Nix, it helps understand project dependencies and optimize builds.
*   **Derivation:** A build instruction in Nix that describes how to build a package or component.
*   **`derivations.jsonl`:** A file containing a line-delimited JSON output, where each line represents a node (derivation) or an edge (dependency) in the Nix build graph.
*   **DRY Principle (Don't Repeat Yourself):** A software development principle aimed at reducing repetition of software patterns, replacing it with abstractions or data normalization.

## E
*   **Exit Status (`$?`):** A special shell variable that holds the exit code of the last executed command. 0 typically indicates success, non-zero indicates failure.

## F
*   **`fetchFromGitHub` / `fetchgit`:** Nix functions used to fetch source code from Git repositories, often GitHub.

## G
*   **Git Submodule:** A Git repository embedded inside another Git repository. It allows a project to incorporate and track versioned external projects.
*   **`git submodule add`:** A Git command used to add a new submodule to a repository.
*   **`git submodule update --init --recursive`:** A Git command used to initialize, clone, and update submodules, including nested submodules.

## H
*   **Hyperspace Anomaly:** A metaphorical term used to describe a sudden, unexpected system crash, particularly in the context of the MIB Crash Retrieval Protocol.

## I
*   **Idempotency:** The property of an operation that it can be applied multiple times without changing the result beyond the initial application. In scripting, it means running a script multiple times has the same effect as running it once.

## M
*   **Modularity:** Breaking down complex tasks into smaller, focused functions or units.

## N
*   **Nix Flake:** A self-contained, reproducible Nix project that specifies its inputs and outputs.
*   **Nix Integration:** The practice of using Nix for managing script dependencies, tools, and environments to ensure reproducibility.
*   **`nixpkgs`:** The large collection of Nix expressions (package definitions) that make up the Nix package collection.
*   **`nixtract`:** A tool used to generate a dependency graph for a Nix flake.

## P
*   **Pure Builds:** Nix builds that do not rely on any external factors beyond their declared inputs, ensuring reproducibility.

## S
*   **`shellcheck`:** A static analysis tool for shell scripts that finds common errors and suggests improvements.
*   **Shell Scripting Standards:** Guidelines to improve the quality, maintainability, reliability, and security of shell scripts, ensuring consistency and adherence to best practices.
*   **Shebang:** The first line in a script (e.g., `#!/usr/bin/env bash`) that specifies the interpreter for the script.
*   **SOPs (Standard Operating Procedures):** Formal procedures for common shell scripting tasks and general script development.
*   **`src` attribute:** In Nix expressions, the attribute that specifies the source code for a package.
*   **Strict Mode (`set -euo pipefail`):** A set of shell options that make scripts more robust by exiting on errors (`-e`), treating unset variables as errors (`-u`), and failing if any command in a pipeline fails (`-o pipefail`).
*   **Superproject:** The main Git repository that contains one or more submodules.

## T
*   **`trap`:** A shell built-in command used to execute commands when a signal is received or when the shell exits. Useful for cleanup operations.

## V
*   **Vendorizing:** The practice of obtaining the source code of an external dependency (like a Nix package) and integrating it directly into a project's repository, typically as a Git submodule. This enhances reproducibility and enables offline builds.
