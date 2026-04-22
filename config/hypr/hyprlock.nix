{
  osConfig,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      
      background = [{
        path = osConfig.style.wallpaper.path;
      }];

      input-field = [{
        size = "200, 60";
        position = "0, -120";
        monitor = "";
        # Fixed the extra '}' here
        font_color = "rgb(${osConfig.style.colors.base01})"; 
        # Correctly accessing the first font in the list
        font_family = "${builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace}";
        inner_color = "rgb(${osConfig.style.colors.base0E})";
        outer_color = "rgb(${osConfig.style.colors.base0A})";
        outline_thickness = 0;
        placeholder_text = "";
        fail_color = "rgb(${osConfig.style.colors.base08})";
        check_color = "rgb(${osConfig.style.colors.base0B})";
      }];

      label = [{
        monitor = "";
        text = "cmd[update:1000] echo -e \"\$(date +\"%H:%M\")\"";
        color = "rgb(${osConfig.style.colors.base07})";
        font_size = 120;
        font_family = "${builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace}";
        position = "200, -200";
        halign = "left";
        valign = "top";
      }];
    };
  };
}
