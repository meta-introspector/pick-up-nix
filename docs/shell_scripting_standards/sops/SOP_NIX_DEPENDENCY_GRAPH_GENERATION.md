# SOP: Nix Flake Dependency Graph Generation

## 1. Purpose

This Standard Operating Procedure (SOP) outlines the steps to generate a dependency graph for a Nix flake using the `nixtract` tool. This graph is valuable for understanding project dependencies, optimizing builds, identifying redundant components, and creating smaller test cores.

## 2. Scope

This SOP applies to all Nix flakes within the Pick-Up-Nix project that require dependency analysis.

## 3. Prerequisites

*   Nix installed on your system (version 2.4 or later recommended).
*   Internet connectivity to fetch `nixtract` (if not cached in your Nix store).

## 4. Procedure

### 4.1. Using the `generate_nix_graph.sh` Script

The project provides a convenience script, `generate_nix_graph.sh`, to automate the process of generating the dependency graph.

1.  **Navigate to the Project Root (Optional but Recommended):**
    It is recommended to execute the script from the root directory of your `pick-up-nix` project.
    ```bash
    cd /data/data/com.termux.nix/files/home/pick-up-nix/
    ```

2.  **Execute the Script:**
    Run the `generate_nix_graph.sh` script. You can specify the target Nix flake as an argument. If no argument is provided, the script will default to the current working directory as the flake reference.

    *   **To generate the graph for the current project flake:**
        ```bash
        ./generate_nix_graph.sh
        ```

    *   **To generate the graph for a specific flake (e.g., an external flake or a sub-flake):**
        ```bash
        ./generate_nix_graph.sh <FLAKE_REFERENCE>
        ```
        Replace `<FLAKE_REFERENCE>` with the absolute path to the flake directory (e.g., `/data/data/com.termux.nix/files/home/pick-up-nix/nixpacks/`) or a valid flake URI (e.g., `github:NixOS/nixpkgs#hello`).

    The script will output progress messages to the console. The generated dependency graph data will be saved to a file named `derivations.jsonl` in the directory from which the script was executed.

### 4.2. Reviewing the Output

The `derivations.jsonl` file contains a line-delimited JSON output. Each line represents a node (derivation) or an edge (dependency) in the Nix build graph. You can inspect this file using standard command-line tools:

*   **View first few lines:**
    ```bash
    head derivations.jsonl
    ```
*   **View last few lines:**
    ```bash
    tail derivations.jsonl
    ```
*   **Pretty-print a single JSON object (requires `jq`):**
    ```bash
    head -n 1 derivations.jsonl | jq .
    ```

## 5. Troubleshooting

*   **"flake reference '.' is not an absolute path" error:**
    This error occurs if `nixtract` is invoked with a relative path for `--target-flake-ref` and it expects an absolute one. The `generate_nix_graph.sh` script attempts to handle this by using `$(pwd)`, but if you are calling `nixtract` directly, ensure you provide an absolute path or a valid flake URI.

*   **Long execution time/large output:**
    For very large flakes, generating the full graph can take a significant amount of time and produce a very large `derivations.jsonl` file. Consider:
    *   Analyzing specific outputs or sub-flakes if possible.
    *   Using `nixtract`'s filtering options (refer to `nixtract --help` for details) if you only need a subset of the graph.

*   **`nix run` errors:**
    Ensure your Nix installation is correctly configured and that you have network access to fetch `nixtract` and any flake inputs.

## 6. Related Documentation

*   [Shell Script Best Practices](../shell_script_best_practices.md)
*   [nixtract GitHub Repository](https://github.com/tweag/nixtract)
