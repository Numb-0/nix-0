# style.nix
{ 
  lib,
  config,
  pkgs,
  ... 
}:
with lib;
let
  colorSchemes = {
    catppuccin = {
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
    gruvbox = {
      base00 = "282828"; # dark0
      base01 = "3c3836"; # dark1
      base02 = "504945"; # dark2
      base03 = "665c54"; # dark3
      base04 = "bdae93"; # light0
      base05 = "d5c4a1"; # light1
      base06 = "ebdbb2"; # light2
      base07 = "fbf1c7"; # light3
      base08 = "fb4934"; # red
      base09 = "fe8019"; # orange
      base0A = "fabd2f"; # yellow
      base0B = "b8bb26"; # green
      base0C = "8ec07c"; # aqua
      base0D = "83a598"; # blue
      base0E = "d3869b"; # purple
      base0F = "d65d0e"; # brown
    };
  };
in
{
  options.style = {
    enable = mkEnableOption "Enable Colors";
    scheme = mkOption {
      type = types.enum (attrNames colorSchemes);
      default = "catppuccin";
      description = "Select a base-16 color scheme.";
    };
    colors = mkOption {
      type = types.attrs;
      default = colorSchemes.${config.style.scheme};
      description = "The selected color scheme colors.";
    };
    cursor = {
      name = mkOption {
        type = types.str;
        default = "Adwaita";
        description = "The name of the cursor theme.";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.adwaita-icon-theme;
        description = "The package providing the cursor theme.";
      };
      size = mkOption {
        type = types.int;
        default = 24;
        description = "The size of the cursor.";
      };
    };
    wallpaper = mkOption {
      type = types.path;
      description = "The path to the current wallpaper";
    };
  };
  config = mkIf config.style.enable {
    style.colors = colorSchemes.${config.style.scheme};
  };
}