{
  pkgs,
  self,
  ...
}:
  pkgs.writeShellScriptBin "setup_nvim" ''
  #!/usr/bin/env bash

  mkdir -p ~/.config/nvim
  cp -r ${self}/config/nvim/* ~/.config/nvim

  echo "Nvim setup complete!"
  ''
