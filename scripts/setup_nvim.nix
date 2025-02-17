{
  pkgs,
  config,
  ...
}:
  pkgs.writeShellScriptBin "setup_nvim" ''
  #!/usr/bin/env bash

  mkdir -p ~/.config/nvim
  cp -r $HOME/nix-0/config/nvim/* ~/.config/nvim

  echo "Nvim setup complete!"
  ''
