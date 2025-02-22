{
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          jnoortheen.nix-ide
          catppuccin.catppuccin-vsc
          #catppuccin.catppuccin-vsc-icons
          # Add any packages you want here
        ];
        userSettings = {
          nix = {
            enableLanguageServer = true;
            serverPath = "nil";
          };
          workbench = {
            colorTheme = "Catppuccin Macchiato";
            #iconTheme = "catppuccin-macchiato";
          };
          editor = {
            fontFamily = "JetBrainsMono Nerd Font Mono";
          };
        };
      };
    };
  };
}
