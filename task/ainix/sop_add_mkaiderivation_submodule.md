# Standard Operating Procedure: Adding the mkAIDerivation Git Submodule

## 1. Purpose
This SOP details the process for integrating the `mkAIDerivation` Git repository as a submodule into the main project. This ensures consistent management and version control of this external dependency.

## 2. Scope
This SOP applies to all developers and contributors responsible for managing project dependencies.

## 3. Prerequisites
*   Access to the main Git repository.
*   Git installed and configured.
*   Internet connectivity to access `https://github.com/meta-introspector/mkAIDerivation.git`.

## 4. Procedure

### 4.1. Execute the Submodule Addition Script
Use the provided shell script to automate the addition of the `mkAIDerivation` submodule. This script handles the `git submodule add` command, logging, and basic error checking.

```bash
bash /data/data/com.termux.nix/files/home/pick-up-nix2/task/ainix/add_mkaiderivation_submodule.sh
```

### 4.2. Review Script Output and Logs
After execution, carefully review the output of the script in your terminal. Detailed logs, including `strace` output, will be available in:

```
/data/data/com.termux.nix/files/home/pick-up-nix2/task/ainix/logs/add_mkaiderivation_submodule.log
```
Check for any error messages or unexpected behavior.

### 4.3. Commit Changes to the Main Repository
If the submodule was added successfully, Git will have modified `.gitmodules` and created the `vendor/mkAIDerivation` directory. These changes need to be committed to the main repository.

```bash
git add .gitmodules vendor/mkAIDerivation
git commit -m "Add mkAIDerivation submodule"
```

## 5. Verification
To confirm the successful addition of the submodule:

*   **Check Git Status:** Run `git status` in the main repository to ensure no pending changes related to the submodule.
*   **Verify Submodule Status:** Run `git submodule status` to confirm `mkAIDerivation` is listed and correctly initialized.
*   **Inspect Directory:** Verify that the `vendor/mkAIDerivation` directory exists and contains the contents of the `mkAIDerivation` repository.
*   **Review .gitmodules:** Confirm that `.gitmodules` contains an entry for `mkAIDerivation` pointing to the correct URL and path.
