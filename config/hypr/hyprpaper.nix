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
