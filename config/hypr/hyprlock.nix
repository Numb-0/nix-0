{
  config,
  ...
}:
{
  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 10;
          hide_cursor = true;
        };
        background = [
          {
            path = "${config.stylix.image}";      
          }
        ];
        input-field = [
          {
            size = "200, 60";
            position = "0, -120";
            monitor = "";
            font_color = "rgb(${config.stylix.base16Scheme.base01})";
            font_family = "JetBrainsMono Nerd Font Mono";
            inner_color = "rgb(${config.stylix.base16Scheme.base0E})";
            outer_color = "rgb(${config.stylix.base16Scheme.base0A})";
            outline_thickness = 0;
            placeholder_text = "";
            fail_color = "rgb(${config.stylix.base16Scheme.base08})";
            check_color = "rgb(${config.stylix.base16Scheme.base0B})";
          }
        ];
        label = [
          {
            monitor = "";
            text = "cmd[update:1000] echo -e \"\$(date +\"%H:%M\")\"";
            color = "rgb(${config.stylix.base16Scheme.base07})";
            font_size = 120;
            font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
            position = "200, -200";
            halign = "left";
            valign = "top";
          }
        ];
      };
    };
  };
}
