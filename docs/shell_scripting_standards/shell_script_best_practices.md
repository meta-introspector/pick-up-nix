# Shell Script Best Practices

This document outlines the recommended best practices for writing shell scripts within the Pick-Up-Nix project. Adhering to these guidelines will improve script quality, maintainability, reliability, and security.

## 1. General Script Structure and Robustness

### 1.1. Consistent Shebang

Always start your scripts with the following shebang for maximum portability and to ensure the script is executed with `bash` from the user's PATH:

```bash
#!/usr/bin/env bash
```

### 1.2. Strict Mode (Essential!)

Include the following line at the beginning of every script to enable strict error checking. This is crucial for preventing silent failures and unexpected behavior.

```bash
set -euo pipefail
```

*   `set -e`: Exit immediately if a command exits with a non-zero status.
*   `set -u`: Treat unset variables as an error.
*   `set -o pipefail`: The return value of a pipeline is the exit status of the last command that exited with a non-zero status, or zero if all commands in the pipeline exit successfully.

## 2. Error Handling and Input Validation

### 2.1. Robust Error Checking

Always check the exit status of critical commands. Do not assume success. Provide informative error messages.

```bash
if ! command_to_run; then
    echo "Error: Command 'command_to_run' failed." >&2
    exit 1
fi
```

### 2.2. Input Validation

Validate all script arguments and user inputs. Provide clear usage instructions if arguments are missing or invalid.

```bash
if [ -z "$1" ]; then
    echo "Usage: $0 <required_argument>" >&2
    exit 1
fi
```

### 2.3. Cleanup on Exit (Trap)

Use `trap` to perform cleanup actions (e.g., removing temporary files) when the script exits, either successfully or due to an error.

```bash
cleanup() {
    echo "Cleaning up temporary files..."
    rm -f /tmp/my_temp_file
}

trap cleanup EXIT
```

## 3. Variables and Quoting

### 3.1. Consistent Quoting

Always double-quote variables and command substitutions to prevent word splitting and globbing issues.

```bash
# Bad
# echo $my_var
# for file in *.txt; do ...

# Good
echo "$my_var"
for file in "*.txt"; do ... # Use globbing carefully, or find -print0 | xargs -0
```

### 3.2. Meaningful Variable Names

Use descriptive and clear names for variables.

```bash
# Bad
# a="temp"

# Good
temp_directory="/tmp/my_app"
```

### 3.3. Minimize Hardcoded Paths

Avoid hardcoding absolute paths. Use relative paths, environment variables, or pass paths as arguments.

## 4. Code Organization and Readability

### 4.1. Modularity and Functions

Break down complex logic into smaller, reusable functions. This improves readability and maintainability.

```bash
my_function() {
    # Function logic here
    echo "Executing my_function"
}

my_function
```

### 4.2. DRY Principle (Don't Repeat Yourself)

Avoid code duplication. If a block of code is repeated, consider creating a function or sourcing a common library script.

### 4.3. Clear and Concise Comments

Add comments to explain *why* a particular piece of code exists or *how* complex logic works, rather than just *what* it does.

### 4.4. Consistent Formatting

Use consistent indentation, spacing, and naming conventions throughout your scripts.

## 5. Idempotency

Design scripts to be runnable multiple times without unintended side effects. Check if a resource exists or a configuration is applied before attempting to create/apply it.

```bash
if [ ! -d "/path/to/my_dir" ]; then
    mkdir "/path/to/my_dir"
fi
```

## 6. Logging

Implement a consistent logging mechanism (e.g., `log_info`, `log_warn`, `log_error` functions) that includes timestamps and relevant context. This aids in debugging and auditing.

## 7. Security Considerations

### 7.1. Least Privilege

Run scripts with the minimum necessary permissions. For remote operations, ensure `sudo` is used with specific commands, not blanket access.

### 7.2. Secure Remote Operations

*   Use SSH keys for authentication, not passwords.
*   Validate remote command outputs.
*   Consider dedicated configuration management tools (e.g., Ansible, NixOps) for complex remote deployments.

## 8. Nix-Specific Best Practices

### 8.1. Leverage Nix

Utilize Nix for dependency management, environment setup, and deployments to improve reproducibility and consistency. This includes using Nix for managing Python environments where applicable.

### 8.2. Pure Builds

Strive for pure Nix builds. Justify the use of `--impure` in Nix commands and minimize its usage.

### 8.3. Effective Nix Commands

Use `nix build`, `nix run`, `nix develop`, and `nix shell` effectively based on your needs.
