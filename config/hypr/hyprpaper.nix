{
  osConfig,
  ...
}:
{
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        # preload = osConfig.style.wallpaper.paths;
        splash = false;
        wallpaper = [
          {
            monitor = " ";
            path = "${osConfig.style.wallpaper.path}";
            # fit_mode = "cover";
          }
        ];
      };
    };
  };
}
