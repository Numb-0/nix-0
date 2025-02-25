{
  pkgs,
  osConfig,
  ...
}:
let 
  colortheme = {
    "catppuccin" = "Catppuccin Macchiato";
    "gruvbox" = "Gruvbox Dark Medium";
  }.${osConfig.style.scheme} or "Default Dark Modern";
  icontheme = {
    "gruvbox" = "gruvbox-material-icon-theme";
  }.${osConfig.style.scheme} or "material-icon-theme";
in
{
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          # TODO make package vscode-extensions gruvbox material icon theme
          bbenoist.nix
          jnoortheen.nix-ide
          catppuccin.catppuccin-vsc
          pkief.material-icon-theme
          jdinhlife.gruvbox
          esbenp.prettier-vscode
        ];
        userSettings = {
          nix = {
            enableLanguageServer = true;
            serverPath = "nil";
          };
          workbench = {
            colorTheme = colortheme;
            iconTheme = icontheme;
          };
          editor = {
            fontFamily = "JetBrainsMono Nerd Font Mono";
          };
        };
      };
    };
  };
}
