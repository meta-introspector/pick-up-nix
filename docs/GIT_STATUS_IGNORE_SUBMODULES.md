# `git status --ignore-submodules`

This command is used to show the working tree status while ignoring changes within submodules.

## Usage

```bash
git status --ignore-submodules[=<mode>]
```

### Modes

-   **none**: All changes in submodules are shown (default behavior).
-   **untracked**: Submodule content changes are ignored, but untracked files in the submodule are still shown.
-   **dirty**: All changes in submodules are ignored, including untracked files and modified tracked files.
-   **all**: All changes in submodules are ignored, including modified tracked files, untracked files, and new commits in the submodule.

## Example

To check the status of your repository, ignoring any changes within its submodules:

```bash
git status --ignore-submodules=dirty
```
