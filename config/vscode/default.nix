{
  osConfig,
  ...
}:
let
  colortheme =
    {
      "catppuccin" = "Catppuccin Macchiato";
      "gruvbox" = "Gruvbox Dark Medium";
    }
    .${osConfig.style.scheme} or "Default Dark Modern";
  icontheme =
    {
      "gruvbox" = "gruvbox-material-icon-theme";
      "catppuccin" = "material-icon-theme";
    }
    .${osConfig.style.scheme} or "material-icon-theme";
in
{
  programs.vscode = {
    enable = true;
  };
  xdg.configFile."Code/User/settings.json".text = ''
    {
      "workbench": {
        "colorTheme": "${colortheme}",
        "iconTheme": "${icontheme}"
      },
      "editor": {
        "fontFamily": "JetBrainsMono Nerd Font Mono"
      },
      "[scss]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      },
      "[typescriptreact]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      },
      "nix.enableLanguageServer": true,
      "nix.serverPath": "nil",
      "nix.serverSettings": {
        "nil": {
          "formatting": { "command": ["nixfmt"] }
        }
      }
    }
  '';
}
