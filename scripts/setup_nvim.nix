{
  pkgs,
  config,
  ...
}:
  pkgs.writeShellScriptBin "setup_nvim" ''
  #!/usr/bin/env bash

  # Create the AGS configuration directory if needed
  mkdir -p ~/.config/nvim

  colorpath="$HOME/nix-0/config/nvim/lua/numb-0/plugins/mini16.lua"

  #echo 'return {
  #  "echasnovski/mini.nvim", version = "*",
  #  config = function()
  #    require("mini.base16").setup({
  #      palette = {
  #        base00 = "#${config.stylix.base16Scheme.base00}",
  #        base01 = "#${config.stylix.base16Scheme.base01}",
  #        base02 = "#${config.stylix.base16Scheme.base02}",
  #        base03 = "#${config.stylix.base16Scheme.base03}",
  #        base04 = "#${config.stylix.base16Scheme.base04}",
  #        base05 = "#${config.stylix.base16Scheme.base05}",
  #        base06 = "#${config.stylix.base16Scheme.base06}",
  #        base07 = "#${config.stylix.base16Scheme.base07}",
  #        base08 = "#${config.stylix.base16Scheme.base08}",
  #        base09 = "#${config.stylix.base16Scheme.base09}",
  #        base0A = "#${config.stylix.base16Scheme.base0A}",
  #        base0B = "#${config.stylix.base16Scheme.base0B}",
  #        base0C = "#${config.stylix.base16Scheme.base0C}",
  #        base0D = "#${config.stylix.base16Scheme.base0D}",
  #        base0E = "#${config.stylix.base16Scheme.base0E}",
  #        base0F = "#${config.stylix.base16Scheme.base0F}",
  #      },
  #      plugins = { default = true },
  #    })
  #  end
  #}
  #' > $colorpath
  cp -r $HOME/nix-0/config/nvim/* ~/.config/nvim

  echo "Nvim setup complete!"
  ''