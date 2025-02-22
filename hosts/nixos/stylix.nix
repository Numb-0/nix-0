{
  pkgs,
  username,
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
      # Since i'm not styling fish i have to style ranger separately
      fish.enable = false;
      vscode.enable = false;
      #qt.enable = false;
      kitty.enable = false;
    };
  };
  # Styling Options
  stylix = {
    enable = true;
    
    # Default wallpaper &/or color scheme generator
    image = ../../config/wallpapers/abstractswirls.jpg;

    # Macchiato
    base16Scheme = {
      base00 = "24273a"; # base
      base01 = "1e2030"; # mantle
      base02 = "363a4f"; # surface0
      base03 = "494d64"; # surface1
      base04 = "5b6078"; # surface2
      base05 = "cad3f5"; # text
      base06 = "f4dbd6"; # rosewater
      base07 = "b7bdf8"; # lavender
      base08 = "ed8796"; # red
      base09 = "f5a97f"; # peach
      base0A = "eed49f"; # yellow
      base0B = "a6da95"; # green
      base0C = "8bd5ca"; # teal
      base0D = "8aadf4"; # blue
      base0E = "c6a0f6"; # mauve
      base0F = "f0c6c6"; # flamingo
    };

    polarity = "dark";

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      /* monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      }; */
      emoji = {
        package = pkgs.noto-fonts-emoji;
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
