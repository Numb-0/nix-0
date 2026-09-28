{
  lib,
  config,
  ...
}:
with lib;
let
  wallpaperDir = builtins.path {
    path = ../../config/wallpapers;
    name = "wallpapers";
  };
  wallpaperImgs = builtins.readDir wallpaperDir;
  wallpaperPaths = builtins.map (file: "${toString wallpaperDir}/${file}") (
    builtins.attrNames wallpaperImgs
  );
  # Colours come from chromix, generated from the wallpaper; the
  # scheme only picks which wallpaper it starts from.
  wallpaperIndexes = {
    "catppuccin" = 0;
    "gruvbox" = 1;
  };
  wallpaperIndex = wallpaperIndexes.${config.style.scheme};
in
{
  options.style = {
    enable = mkEnableOption "Enable Colors";
    scheme = mkOption {
      type = types.enum (attrNames wallpaperIndexes);
      default = "catppuccin";
      description = "The wallpaper chromix starts from.";
    };
    wallpaper = {
      path = mkOption {
        type = types.path;
        description = "The path to the current wallpaper";
      };
      paths = mkOption {
        type = types.listOf types.path;
        description = "The list of the paths to the wallpapers";
      };
    };
  };
  config = mkIf config.style.enable {
    style.wallpaper.paths = wallpaperPaths;
    style.wallpaper.path = builtins.elemAt wallpaperPaths wallpaperIndex;
  };
}
