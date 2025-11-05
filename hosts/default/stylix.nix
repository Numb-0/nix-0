{
  pkgs,
  username,
  config,
  ...
}:
let
  fontsize = 11;
in
{
  # Applications to NOT style
  home-manager.users.${username} = {
    stylix.targets = {
      hyprpaper.enable = false;
      hyprlock.enable = false;
      hyprland.enable = false;
      fish.enable = false;
      vscode.enable = false;
      kitty.enable = false;
      # ghostty.enable = false;
      qt.enable = false;
    };
  };

  stylix = {
    enable = true;

    image = config.style.wallpaper.path;
    base16Scheme = config.style.colors;

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = fontsize;
        terminal = fontsize;
        desktop = fontsize;
        popups = fontsize;
      };
    };
  };
}
