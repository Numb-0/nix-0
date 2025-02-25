{
  osConfig,
  ...
}:
{
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = osConfig.style.wallpaper.paths;
        wallpaper = ",${osConfig.style.wallpaper.path}";
      };
    };
  };
}
