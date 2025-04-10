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
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
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
