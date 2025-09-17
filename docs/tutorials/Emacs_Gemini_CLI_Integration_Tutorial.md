# Tutorial: Emacs Integration with Gemini CLI

This tutorial guides you through setting up and using the Emacs Lisp integration for the `gemini-cli` tool. This integration allows you to interact with the Gemini CLI directly from Emacs, enabling interactive commands and automated task processing.

## Prerequisites:
- Emacs installed and configured.
- The `gemini-cli` tool accessible via the Nix command specified in `solfunmeme-gemini.el`.
- The project repository cloned to `~/pick-up-nix2/`.

## 1. Understanding the Integration Files:

The core of the integration is provided by two Emacs Lisp files:

-   **`solfunmeme-gemini.el`**: Located at `source/github/meta-introspector/git-submodule-tools-rs/.emacs.d/nix-magit/solfunmeme-gemini.el`
    -   Defines the Nix command for `gemini-cli`.
    -   Sets the project root and prelude file paths.
    -   Provides functions to retrieve task files and run `gemini-cli` for individual tasks, saving output to `.out1.md` files.

-   **`solfunmeme-mode.el`**: Located at `source/github/meta-introspector/git-submodule-tools-rs/.emacs.d/nix-magit/solfunmeme-mode.el`
    -   Defines a new major mode, `solfunmeme-mode`.
    -   Requires `solfunmeme-gemini.el`.
    -   Provides a keybinding (`C-c C-r`) to manually run all Gemini tasks.
    -   Includes a timer to automatically run all Gemini tasks at regular intervals (default 5 minutes).

## 2. Setting up Emacs:

To enable the integration, you need to add the directory containing these `.el` files to your Emacs `load-path` and then load `solfunmeme-mode`.

1.  **Add to `load-path`**:
    Open your Emacs configuration file (e.g., `~/.emacs.d/init.el` or `~/.emacs`). Add the following line:
    ```elisp
    (add-to-list 'load-path "/data/data/com.termux.nix/files/home/pick-up-nix2/source/github/meta-introspector/git-submodule-tools-rs/.emacs.d/nix-magit/")
    ```
    *Make sure the path is correct for your setup.*

2.  **Load `solfunmeme-mode`**:
    In your Emacs configuration, add the following line to load the mode:
    ```elisp
    (require 'solfunmeme-mode)
    ```

3.  **Restart Emacs** (or evaluate the new lines in your configuration) for the changes to take effect.

## 3. Using the Integration:

Once `solfunmeme-mode` is loaded, you can use the following functionalities:

1.  **Activate `solfunmeme-mode`**:
    Open any file in Emacs. You can activate the mode manually by typing `M-x solfunmeme-mode` (where `M-x` typically means `Alt-x` or `Esc-x`). You can also configure Emacs to automatically activate this mode for specific file types or directories.

2.  **Manually Run All Gemini Tasks**:
    With `solfunmeme-mode` active, press `C-c C-r`.
    This will execute `gemini-cli` for all task files found in your `prompts/` directory, generating `.out1.md` files for each.

3.  **Automated Task Processing**:
    The mode includes a timer that automatically runs all Gemini tasks every `solfunmeme-auto-run-interval` seconds (default is 5 minutes). This happens in the background once the mode is active.

## 4. Customization:

You can customize the `solfunmeme-auto-run-interval` and other potential future configurable items:

-   Type `M-x customize-group solfunmeme`.
-   This will open a customization buffer where you can change the interval and other settings. Remember to save your changes.

## Troubleshooting:
-   If commands are not found, ensure your `load-path` is correct and `solfunmeme-mode` is loaded.
-   Check the `*Messages*` buffer in Emacs for any errors.
-   Verify that `gemini-cli` is accessible via the Nix command specified in `solfunmeme-gemini.el`.

This concludes the tutorial for Emacs integration with Gemini CLI. For further development, consider adding more configurable items and a graphical user interface.
