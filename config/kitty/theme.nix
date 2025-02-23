{
  osConfig,
  ...
}:
let
  colors = osConfig.style.colors;
in
{
  xdg.configFile."kitty/theme.conf".text = ''
  # The basic colors
  foreground                #${colors.base05}
  background                #${colors.base00}
  selection_foreground      #${colors.base00}
  selection_background      #${colors.base05}

  # Cursor colors
  cursor                    #${colors.base05}
  cursor_text_color         #${colors.base00}

  # URL underline color when hovering with mouse
  url_color                 #${colors.base06}

  # Kitty window border colors
  active_border_color       #${colors.base07}
  inactive_border_color     #${colors.base05}
  bell_border_color         #${colors.base0A}

  # OS Window titlebar colors
  wayland_titlebar_color system
  macos_titlebar_color system

  # Tab bar colors
  active_tab_foreground     #${colors.base05}
  active_tab_background     #${colors.base0E}
  inactive_tab_foreground   #${colors.base05}
  inactive_tab_background   #${colors.base00}
  tab_bar_background        #${colors.base00}

  # Colors for marks (marked text in the terminal)
  mark1_foreground   #${colors.base00}
  mark1_background   #${colors.base07}
  mark2_foreground   #${colors.base00}
  mark2_background   #${colors.base0E}
  mark3_foreground   #${colors.base00}
  mark3_background   #${colors.base0C}

  # The 16 terminal colors

  # black
  color0   #${colors.base03}
  color8   #${colors.base04}

  # red
  color1   #${colors.base08}
  color9   #${colors.base08}

  # green
  color2   #${colors.base0B}
  color10  #${colors.base0B}

  # yellow
  color3   #${colors.base0A}
  color11  #${colors.base0A}

  # blue
  color4   #${colors.base0D}
  color12  #${colors.base0D}

  # magenta
  color5   #${colors.base06}
  color13  #${colors.base06}

  # cyan
  color6   #${colors.base0C}
  color14  #${colors.base0C}

  # white
  color7   #${colors.base04}
  color15  #${colors.base05}
  '';
}