{
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # Add any packages you want here
    ];
    userSettings = {
      workbench = {
        colorTheme = "Catppuccin Macchiato";
        iconTheme = "catppuccin-macchiato";
      };
      nix = {
        enableLanguageServer = true;
        serverPath = "nil";
      };
    };
  };
}
