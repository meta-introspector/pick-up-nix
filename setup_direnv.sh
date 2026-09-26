#!/usr/bin/env bash

# Function to log messages
log() {
  echo "[INFO] $1"
}

# Function to log errors
error() {
  echo "[ERROR] $1" >&2
  exit 1
}

# --- Step 1: Check for direnv installation ---
log "Checking for direnv installation..."
if command -v direnv &> /dev/null; then
  log "direnv is already installed."
  DIRENV_INSTALLED=true
else
  log "direnv is not installed. Attempting to install via Nix..."
  DIRENV_INSTALLED=false

  # --- Step 2: Install direnv via Nix ---
  # Check if shell.nix exists and add direnv to it
  SHELL_NIX_PATH="/data/data/com.termux.nix/files/home/pick-up-nix/shell.nix"
  if [ -f "$SHELL_NIX_PATH" ]; then
    if ! grep -q "direnv" "$SHELL_NIX_PATH"; then
      log "Adding direnv to existing shell.nix..."
      # Using sed to insert 'direnv' before the closing '];'
      if ! sed -i '/];/i 
  direnv' "$SHELL_NIX_PATH"; then
        error "Failed to add direnv to shell.nix."
      fi
      log "direnv added to shell.nix. You will need to re-enter your nix-shell for this to take effect."
    else
      log "direnv already present in shell.nix."
    fi
  else
    error "shell.nix not found at $SHELL_NIX_PATH. Cannot automatically install direnv."
  fi
fi

# --- Step 3: Add direnv hook to shell configuration ---
log "Attempting to add direnv hook to shell configuration..."

SHELL_CONFIG_FILE=""
if [[ "$SHELL" == *bash* ]]; then
  SHELL_CONFIG_FILE="$HOME/.bashrc-cursor"
  HOOK_COMMAND="eval $(direnv hook bash)"
elif [[ "$SHELL" == *zsh* ]]; then
  SHELL_CONFIG_FILE="$HOME/.zshrc"
  HOOK_COMMAND="eval $(direnv hook zsh)"
elif [[ "$SHELL" == *fish* ]]; then
  SHELL_CONFIG_FILE="$HOME/.config/fish/config.fish"
  HOOK_COMMAND='direnv hook fish | source'
else
  log "Could not detect shell or unsupported shell. Please manually add the direnv hook to your shell configuration file."
fi

if [ -n "$SHELL_CONFIG_FILE" ]; then
  if [ -f "$SHELL_CONFIG_FILE" ]; then
    if ! grep -q "direnv hook" "$SHELL_CONFIG_FILE"; then
      echo -e "\n# Added by setup_direnv.sh" >> "$SHELL_CONFIG_FILE"
      echo "$HOOK_COMMAND" >> "$SHELL_CONFIG_FILE"
      log "Added direnv hook to $SHELL_CONFIG_FILE. Please source it or open a new terminal."
    else
      log "direnv hook already present in $SHELL_CONFIG_FILE."
    fi
  else
    log "Shell configuration file $SHELL_CONFIG_FILE not found. Please manually add the direnv hook."
  fi
fi

# --- Step 4: Create .envrc in the current directory ---
log "Creating .envrc file in the current directory..."
ENVRC_PATH="./.envrc"
if [ ! -f "$ENVRC_PATH" ]; then
  echo "use nix" > "$ENVRC_PATH"
  log "Created $ENVRC_PATH with 'use nix'."
else
  if ! grep -q "use nix" "$ENVRC_PATH"; then
    echo -e "\nuse nix" >> "$ENVRC_PATH"
    log "Added 'use nix' to existing $ENVRC_PATH."
  else
    log "'use nix' already present in $ENVRC_PATH."
  fi
fi

# --- Step 5: Run direnv allow ---
log "Running 'direnv allow' for the current directory..."
if command -v direnv &> /dev/null; then
  if ! direnv allow .; then
    error "Failed to run 'direnv allow .'. Make sure direnv is correctly installed and sourced."
  fi
  log "'direnv allow .' executed successfully."
else
  log "direnv command not found. Skipping 'direnv allow'."
fi

# --- Step 6: Print a report ---
echo ""
echo "--- direnv Setup Report ---"
echo "1. direnv Installation Status: $(if [ "$DIRENV_INSTALLED" = true ]; then echo "Already installed"; else echo "Attempted installation via Nix"; fi)"
if [ "$DIRENV_INSTALLED" = false ]; then
  echo "   (Note: If direnv was installed via Nix, you need to re-enter your nix-shell for it to be available in PATH.)"
fi
echo "2. direnv Hook: $(if [ -n "$SHELL_CONFIG_FILE" ] && grep -q "direnv hook" "$SHELL_CONFIG_FILE"; then echo "Added to $SHELL_CONFIG_FILE"; else echo "Manual action may be required"; fi)"
echo "   (Action: Please source your shell config file or open a new terminal for the hook to take effect.)"
echo "3. .envrc File: $(if [ -f "$ENVRC_PATH" ]; then echo "Created/Updated $ENVRC_PATH"; else echo "Failed to create $ENVRC_PATH"; fi)"
echo "4. direnv allow: $(if command -v direnv &> /dev/null && direnv allow .; then echo "Executed successfully"; else echo "Skipped or failed (direnv not in PATH)"; fi)"
echo ""
echo "--- Next Steps ---"
echo "1. If direnv was installed via Nix, exit and re-enter your nix-shell to ensure 'direnv' is in your PATH."
echo "2. Open a new terminal session or run 'source $SHELL_CONFIG_FILE' (replace with your actual config file) to activate the direnv hook."
echo "3. Navigate to your project directory. direnv should now automatically load the Nix environment."
echo "4. If you encounter issues, ensure direnv is installed and its hook is correctly configured for your shell."
