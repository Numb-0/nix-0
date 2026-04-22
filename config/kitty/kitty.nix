{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      include = "./theme.conf";
      confirm_os_window_close = 0;
      cursor_trail = 3;
      font_family = "JetBrains Mono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };
  };
}
