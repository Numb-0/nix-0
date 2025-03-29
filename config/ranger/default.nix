{
  self,
  ...
}:
{
  xdg.configFile."ranger/colorschemes/theme.py" = {
    source = "${self}/config/ranger/theme.py";
  };
  programs.ranger = {
    enable = true;
    settings = {
      colorscheme = "theme";
      preview_images = true;
      # preview_images_method = "kitty";
    };
  };
}
