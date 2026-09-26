# SOP: Shell Scripting Best Practices

## 1. Purpose

This Standard Operating Procedure (SOP) provides a comprehensive guide to writing high-quality, maintainable, reliable, and secure shell scripts within the Pick-Up-Nix project. It formalizes the best practices outlined in `shell_script_best_practices.md` and should be followed for all new and refactored shell scripts.

## 2. Scope

This SOP applies to all shell scripts developed and maintained within the Pick-Up-Nix project, regardless of their specific function (e.g., build scripts, deployment scripts, utility scripts, QA scripts).

## 3. Procedure

### 3.1. Initial Script Setup

*   **Shebang:** Always start your script with `#!/usr/bin/env bash`.
*   **Strict Mode:** Immediately after the shebang, include `set -euo pipefail`.

### 3.2. Argument Handling and Input Validation

*   **Validate Inputs:** For every argument or user input, check for its presence and validity. Provide clear usage messages if inputs are missing or incorrect.
    ```bash
    if [ -z "$1" ]; then
        echo "Usage: $0 <arg1>" >&2
        exit 1
    fi
    ```
*   **Consistent Quoting:** Always double-quote variables and command substitutions (`"$VAR"`, `"$(command)"`) to prevent unexpected behavior.

### 3.3. Error Handling

*   **Check Exit Status:** After every critical command, check its exit status (`$?`). If the command fails, log an error and exit the script with a non-zero status.
    ```bash
    if ! some_command "$arg"; then
        echo "Error: some_command failed." >&2
        exit 1
    fi
    ```
*   **Informative Error Messages:** Error messages should be clear, concise, and provide enough information for debugging.
*   **Cleanup on Exit:** Use `trap` to ensure that temporary files or resources are cleaned up, even if the script exits prematurely due to an error.
    ```bash
    cleanup() {
        rm -rf "$TEMP_DIR"
    }
    trap cleanup EXIT
    ```

### 3.4. Code Organization and Readability

*   **Modularity:** Break down complex tasks into smaller, focused functions. Place functions at the top of the script or in a separate sourced library file.
*   **DRY Principle:** Avoid repeating code. If a block of code appears more than once, create a function for it.
*   **Meaningful Names:** Use descriptive names for variables, functions, and files.
*   **Comments:** Add comments to explain complex logic, design decisions, or non-obvious parts of the code. Focus on *why* rather than *what*.
*   **Formatting:** Maintain consistent indentation (e.g., 2 or 4 spaces), spacing, and line breaks.

### 3.5. Idempotency

*   Design scripts to be idempotent, meaning they can be run multiple times without causing unintended side effects or errors. Check for the existence of files, directories, or configurations before creating/applying them.
    ```bash
    mkdir -p "$LOG_DIR"
    ```

### 3.6. Logging

*   Implement a consistent logging approach. Define simple functions for different log levels (e.g., `log_info`, `log_warn`, `log_error`) that include timestamps.
    ```bash
    log_info() { echo "$(date +'%Y-%m-%d %H:%M:%S') INFO: $@"; }
    log_error() { echo "$(date +'%Y-%m-%d %H:%M:%S') ERROR: $@" >&2; exit 1; }
    ```

### 3.7. Security Considerations

*   **Least Privilege:** Run scripts with the minimum necessary permissions. Avoid running as root unless absolutely required.
*   **Secure Remote Operations:** For scripts interacting with remote systems via SSH, ensure SSH keys are used, and commands executed remotely are carefully vetted. Avoid hardcoding sensitive information.

### 3.8. Nix Integration

*   **Leverage Nix:** Use Nix for managing script dependencies, tools, and environments whenever possible to ensure reproducibility.
*   **Pure Builds:** Minimize the use of `--impure` flags in Nix commands. If used, provide clear justification within the script or associated documentation.

## 4. Review and Testing

*   **Self-Review:** Before committing, review your script against this SOP.
*   **Linting:** Run a shell linter (e.g., `shellcheck`) on your script and address all warnings and errors.
*   **Testing:** Write and execute automated tests (unit and integration) for your script, especially for critical functionalities.

## 5. Maintenance

*   Regularly review and update existing scripts to ensure they continue to adhere to these best practices.
*   Remove commented-out code and unused sections. Rely on version control history for past iterations.
