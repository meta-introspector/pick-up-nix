# Standard Operating Procedure: Updating All Git Submodules

## 1. Purpose
This SOP outlines the process for updating all Git submodules within the main repository to their latest committed versions. This ensures that the project always uses the correct versions of its dependencies.

## 2. Scope
This SOP applies to all developers and contributors working on projects that utilize Git submodules.

## 3. Prerequisites
*   Access to the main Git repository.
*   Git installed and configured.
*   Internet connectivity to fetch updates from submodule remotes.

## 4. Procedure

### 4.1. Execute the Submodule Update Script
Use the provided shell script to automate the initialization and updating of all Git submodules. This script handles the `git submodule update --init --recursive` command, logging, and basic error checking.

```bash
bash /data/data/com.termux.nix/files/home/pick-up-nix2/task/ainix/update_all_submodules.sh
```

### 4.2. Review Script Output and Logs
After execution, carefully review the output of the script in your terminal. Detailed logs, including `strace` output, will be available in:

```
/data/data/com.termux.nix/files/home/pick-up-nix2/task/ainix/logs/update_all_submodules.log
```
Check for any error messages or unexpected behavior.

### 4.3. Commit Changes to the Main Repository (if necessary)
If any submodules were updated to a new commit, Git will record these changes in the main repository. You will need to commit these updates.

```bash
git add .
git commit -m "Update submodules"
```

## 5. Verification
To confirm the successful update of all submodules:

*   **Check Git Status:** Run `git status` in the main repository to ensure no pending changes related to submodules.
*   **Verify Submodule Status:** Run `git submodule status` to confirm all submodules are at their expected commits.
*   **Inspect Submodule Directories:** Navigate into a few submodule directories and run `git log` to ensure they are at the latest desired commit.
