{
  pkgs,
  lib,
  config,
  ...
}: 
with lib;
let
  cfg = config.style;
  fontsize = 11;
in
{
  options.style = {
    enable = mkEnableOption "Enable Stylix";
    theme = mkOption {
      type = types.lines;
      default = "Macchiato";
      description = "Select theme for Stylix";
    };
  };

  config = mkIf cfg.enable {
    # Styling Options
    stylix = {
      enable = true;
      image = ../../config/wallpapers/squares.png;
      base16Scheme = lib.mkMerge [
        (mkIf (cfg.theme == "Macchiato") {
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
        })
        (mkIf (cfg.theme == "RoseDawn") {
          base00 = "faf4ed";
          base01 = "fffaf3";
          base02 = "f2e9de";
          base03 = "9893a5";
          base04 = "797593";
          base05 = "575279";
          base06 = "575279";
          base07 = "cecacd";
          base08 = "b4637a";
          base09 = "ea9d34";
          base0A = "d7827e";
          base0B = "286983";
          base0C = "56949f";
          base0D = "907aa9";
          base0E = "ea9d34";
          base0F = "cecacd";
        })
      ];

      polarity = "dark";
      opacity.terminal = 0.8;
      cursor.package = pkgs.bibata-cursors;
      cursor.name = "Bibata-Modern-Ice";
      cursor.size = 24;

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.roboto;
          name = "Roboto";
        };
        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto-serif";
        };
        sizes = {
          applications = fontsize;
          terminal = fontsize;
          desktop = fontsize;
          popups = fontsize;
        };
      };
    };
  };
}