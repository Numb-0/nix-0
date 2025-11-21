{
  pkgs,
  self,
  ...
}:
  pkgs.writeShellScriptBin "setup_nvim" ''
  #!/usr/bin/env bash
  set -e

  NVIM_DIR="$HOME/.config/nvim"

  echo "Preparing ~/.config/nvim ..."

  # Ensure directory exists
  mkdir -p "$NVIM_DIR"

  # --- FIX PERMISSION ISSUES (your main problem) ---
  echo "Fixing permissions..."
  chmod -R u+rwX "$NVIM_DIR" 2>/dev/null || true

  # Now it's safe to delete content
  echo "Clearing old config..."
  rm -rf "$NVIM_DIR"/*

  echo "Copying new config..."
  cp -r ${self}/config/nvim/.[!.]* "$NVIM_DIR" 2>/dev/null || true # Copies hidden files (e.g., .config, but not . or ..)
  cp -r ${self}/config/nvim/* "$NVIM_DIR"

  echo "Nvim setup complete!"
  ''

