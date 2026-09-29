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
        path = "$wallpaper";
      }];

      input-field = [{
        size = "200, 60";
        position = "0, -120";
        monitor = "";
        font_color = "$m3surfaceContainer"; 
        font_family = "${builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace}";
        inner_color = "$m3magenta";
        outer_color = "$m3yellow";
        outline_thickness = 0;
        placeholder_text = "";
        fail_color = "$m3red";
        check_color = "$m3green";
      }];

      label = [{
        monitor = "";
        text = "cmd[update:1000] echo -e \"\$(date +\"%H:%M\")\"";
        color = "$m3primaryFixed";
        font_size = 120;
        font_family = "${builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace}";
        position = "200, -200";
        halign = "left";
        valign = "top";
      }];
    };
  };
}
