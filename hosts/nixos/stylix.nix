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
    };
  };

  stylix = {
    enable = true;
    
    # Default wallpaper &/or color scheme generator
    image = config.style.wallpaper;
    base16Scheme = config.style.colors;

    polarity = "dark";
    
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      #monospace = {
      #  package = pkgs.nerd-fonts.jetbrains-mono;
      #  name = "JetBrainsMono Nerd Font Mono";
      #};
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
