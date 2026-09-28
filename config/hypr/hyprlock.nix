{
  config,
  osConfig,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = "${config.xdg.stateHome}/chromix/current/hyprlock/colors.conf";

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
        font_color = "rgb($surface_container)"; 
        font_family = "${builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace}";
        inner_color = "rgb($magenta)";
        outer_color = "rgb($yellow)";
        outline_thickness = 0;
        placeholder_text = "";
        fail_color = "rgb($red)";
        check_color = "rgb($green)";
      }];

      label = [{
        monitor = "";
        text = "cmd[update:1000] echo -e \"\$(date +\"%H:%M\")\"";
        color = "rgb($on_primary_container)";
        font_size = 120;
        font_family = "${builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace}";
        position = "200, -200";
        halign = "left";
        valign = "top";
      }];
    };
  };
}
