# Design Document: Emacs GUI for Gemini CLI Integration

## 1. Introduction
This document outlines a conceptual design for a graphical user interface (GUI) within Emacs to enhance the interaction with the `gemini-cli` tool. The goal is to provide a more intuitive and accessible user experience, leveraging Emacs's built-in UI capabilities.

## 2. Core Principles
-   **Emacs-native Look and Feel**: The GUI should integrate seamlessly with Emacs's existing aesthetic and interaction patterns.
-   **Task-centric Workflow**: The primary focus will be on managing and executing `gemini-cli` tasks.
-   **Clear Feedback**: Provide immediate and clear feedback on task status, progress, and output.
-   **Configurability**: Allow users to customize aspects of the GUI and underlying `gemini-cli` calls.

## 3. Proposed GUI Components

### 3.1. Main Gemini Dashboard Buffer
-   A dedicated Emacs buffer (e.g., `*Gemini Dashboard*`) will serve as the central hub.
-   This buffer will be in a special major mode (e.g., `gemini-dashboard-mode`) with specific keybindings.

### 3.2. Task List Display
-   **Location**: Left-hand side of the dashboard buffer, or a separate dedicated window/frame.
-   **Content**: A list of available `gemini-cli` task files (e.g., `prompts/task_XXX.md`).
-   **Interaction**:
    -   Select a task using arrow keys or mouse.
    -   `RET` (Enter) to view task details or initiate execution.
    -   Filtering/searching capabilities for tasks (e.g., using `completing-read`).
-   **Visual Cues**: Icons or text indicators for task status (e.g., "New", "In Progress", "Completed", "Error").

### 3.3. Task Details / Prompt Input Area
-   **Location**: Right-hand side of the dashboard buffer, or a separate temporary buffer.
-   **Content**:
    -   Displays the content of the selected task file (`prompts/task_XXX.md`).
    -   An editable area for modifying the prompt before execution (if desired).
    -   Displays the `prelude.md` content that will be prepended to the prompt.
-   **Interaction**:
    -   Edit task content directly.
    -   Button/keybinding to "Run Gemini CLI" for the current task.

### 3.4. Output Display Area
-   **Location**: Bottom section of the dashboard buffer, or a separate dedicated output buffer (e.g., `*Gemini Output*`).
-   **Content**:
    -   Real-time output from the `gemini-cli` execution.
    -   Displays the content of the generated `.out1.md` file after completion.
    -   Error messages and status updates.
-   **Interaction**:
    -   Scrollable.
    -   Option to save output to a file.

### 3.5. Configuration Panel / Options
-   **Access**: A button or keybinding from the dashboard to open a customization buffer (leveraging `defcustom` variables).
-   **Content**: Allows users to modify `gemini-cli` command, model, project root, auto-run interval, etc.

## 4. User Workflow Example

1.  User opens Emacs and activates `gemini-dashboard-mode` (or it's auto-loaded).
2.  The `*Gemini Dashboard*` buffer appears, showing a list of tasks.
3.  User selects `task_001_emacs_lisp.md` from the list.
4.  The task details and prompt content appear in the input area.
5.  User reviews the prompt and clicks "Run Gemini CLI" (or presses a keybinding).
6.  The output area shows "Running gemini-cli for task_001_emacs_lisp.md..."
7.  Upon completion, the output area displays the content of `task_001_emacs_lisp.md.out1.md`.
8.  The task list updates `task_001_emacs_lisp.md` status to "Completed".

## 5. Technical Considerations
-   **Emacs Lisp**: The entire GUI will be implemented using Emacs Lisp.
-   **Built-in Widgets**: Utilize `widget.el`, `button.el`, `tab-bar.el` (for multi-panel layouts), and `completing-read` for interactive input.
-   **Asynchronous Execution**: `call-process-shell-command` or `start-process` should be used for non-blocking `gemini-cli` execution to keep Emacs responsive.
-   **Org Mode Integration**: (Deferred to a separate CRQ/SOP, but considered in the overall design).

## 6. Visual Mockup (Text-based representation)

```
+---------------------------------------------------------------------+
| *Gemini Dashboard*                                          [X] [?] |
+---------------------------------------------------------------------+
| Tasks:                               | Task Details / Prompt:       |
|--------------------------------------|------------------------------|
| [ ] task_000_review_status.md        | # Task: Emacs Lisp ...       |
| [X] task_001_emacs_lisp.md           |                              |
| [X] task_ainix.md                    | (Editable Prompt Content)    |
| [ ] new_feature_task.md              |                              |
| ...                                  |                              |
|--------------------------------------|------------------------------|
| [Run Gemini CLI] [Config] [Help]     |                              |
+---------------------------------------------------------------------+
| Output:                                                             |
|---------------------------------------------------------------------|
| Running gemini-cli for task_001_emacs_lisp.md...                    |
| Acknowledged. The Emacs Lisp integration for the Gemini CLI is ...  |
| ... (content of .out1.md) ...                                       |
|---------------------------------------------------------------------|
+---------------------------------------------------------------------+
```

## 7. Future Enhancements
-   Integration with Org mode for task definition and output capture.
-   More sophisticated task filtering and sorting.
-   Visual diffing of prompt changes and output.

## Related Documents:
- `docs/crqs/CRQ_Emacs_GUI_Design_for_Gemini_CLI.md`
- `solfunmeme-gemini.el`
- `solfunmeme-mode.el`

## Revision History:
- [Date]: Initial Draft
