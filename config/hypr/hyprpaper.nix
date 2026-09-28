{
  config,
  ...
}:
{
  # No settings: the config is rendered by chromix for every theme, so
  # the wallpaper is always the image the colours came from.
  services.hyprpaper.enable = true;

  xdg.configFile."hypr/hyprpaper.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.stateHome}/chromix/current/hyprpaper/hyprpaper.conf";
}
