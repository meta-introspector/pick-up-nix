# SOP: Vendorizing Nix Package Source Code as a Git Submodule

## 1. Purpose

This Standard Operating Procedure (SOP) details the process of obtaining the source code of a Nix package, specifically from its Git repository, and integrating it into the project as a Git submodule. This practice, known as vendorizing, enhances reproducibility, enables offline builds, and provides greater control over external dependencies.

## 2. Scope

This SOP applies to any Nix package whose primary source is a Git repository and where it is desirable to manage that source directly within the project's repository as a Git submodule.

## 3. Prerequisites

*   Nix installed and configured.
*   Git installed and configured.
*   Familiarity with basic Git commands and Git submodules.
*   Access to the Git repository of the Nix package source.

## 4. Procedure

### 4.1. Identify the Nix Package and its Source Repository

Before vendorizing, you need to determine the Git repository URL and the specific commit hash (or tag/branch) of the source code used by the Nix package.

1.  **Inspect `nixpkgs` or the Package Definition:**
    *   For packages from `nixpkgs`, you can often find the `src` attribute in the package's Nix expression (e.g., `pkgs/applications/version-management/git/default.nix` for Git).
    *   Look for `fetchFromGitHub`, `fetchgit`, or similar functions that specify the repository URL and a `rev` (revision) or `hash`.
    *   Alternatively, you can use `nix-build` to inspect the source derivation:
        ```bash
        nix-build --no-out-link -A <package_attribute_path> -E 'with import <nixpkgs> {}; <package_attribute_path>.src' --json
        ```
        (Replace `<package_attribute_path>` with the actual path, e.g., `pkgs.hello`). The JSON output will contain details about the source, including the Git URL and revision.

2.  **Extract Git URL and Commit Hash:**
    Note down the Git repository URL (e.g., `https://github.com/NixOS/patchelf.git`) and the exact commit hash (SHA-1) that the Nix package is currently using. Using a specific commit hash is crucial for reproducibility.

### 4.2. Prepare the Vendor Directory

Ensure the target directory for the submodule exists. For this project, the standard location for vendored Nix-related sources is `vendor/nix/`.

```bash
mkdir -p vendor/nix/
```

### 4.3. Add as a Git Submodule

Navigate to your project's root directory and add the Git repository as a submodule. Choose a descriptive name for the submodule directory (e.g., the package name).

```bash
git submodule add <GIT_REPO_URL> vendor/nix/<SUBMODULE_NAME>
```
*   Replace `<GIT_REPO_URL>` with the URL obtained in step 4.1.
*   Replace `<SUBMODULE_NAME>` with the desired directory name for the vendored source (e.g., `patchelf`).

This command will clone the repository into `vendor/nix/<SUBMODULE_NAME>` and add an entry to your `.gitmodules` file.

### 4.4. Pin the Submodule to a Specific Commit

To ensure reproducibility, it is vital to pin the submodule to the exact commit hash identified in step 4.1. This prevents unintended updates to the submodule's source.

1.  **Navigate into the Submodule Directory:**
    ```bash
    cd vendor/nix/<SUBMODULE_NAME>
    ```

2.  **Checkout the Specific Commit:**
    ```bash
    git checkout <COMMIT_HASH>
    ```
    Replace `<COMMIT_HASH>` with the exact SHA-1 commit hash obtained in step 4.1.

3.  **Return to Project Root:**
    ```bash
    cd -
    ```

4.  **Record the Submodule Commit in the Superproject:**
    You need to stage the changes in the superproject to record the specific commit the submodule is pointing to.
    ```bash
    git add vendor/nix/<SUBMODULE_NAME>
    ```

### 4.5. Update Nix Expressions to Use the Local Submodule

Modify your `flake.nix` (or other relevant Nix expressions) to use the locally vendored source instead of fetching it from the internet.

1.  **Locate the `src` attribute:** Find where the original Nix package definition specifies its source.
2.  **Change `src` to local path:** Update the `src` attribute to point to the local submodule directory.
    *   **Before (example):**
        ```nix
        src = pkgs.fetchFromGitHub {
          owner = "NixOS";
          repo = "patchelf";
          rev = "<original_rev>";
          sha256 = "<original_sha256>";
        };
        ```
    *   **After (example):**
        ```nix
        src = ./vendor/nix/<SUBMODULE_NAME>;
        ```
    *   If the original source was a `fetchgit` or similar, ensure the new `src` correctly points to the local path.

### 4.6. Verify the Vendorization

After making changes, verify that the package still builds correctly and that it is indeed using the vendored source.

1.  **Build the Package:**
    ```bash
    nix build .#<package_attribute_path>
    ```
    Ensure the build completes successfully.

2.  **Test Offline Builds (Optional but Recommended):**
    To confirm that the vendored source is truly being used and no external fetches are occurring, try building the package in an offline environment (e.g., by temporarily disabling network access or using `nix-build --offline`).

## 5. Troubleshooting

*   **Submodule not found/initialized:** If you clone the main repository, remember to initialize and update submodules:
    ```bash
    git submodule update --init --recursive
    ```
*   **Incorrect commit:** Double-check that the submodule is checked out to the exact commit hash you intended.
*   **Nix build still fetching from internet:** Ensure your Nix expression's `src` attribute is correctly pointing to the local submodule path and not an external URL.

## 6. Related Documentation

*   [Git Submodules Documentation](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
*   [Nixpkgs Manual - `src` attribute](https://nixos.org/manual/nixpkgs/stable/#chap-pkgs-fetchers)
