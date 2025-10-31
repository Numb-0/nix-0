{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      include = "./theme.conf";
      background_opacity = 0.8;
      confirm_os_window_close = 0;
      cursor_trail = 3;
      font_family = "JetBrains Mono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };
    # keybindings = {
      # "ctrl+c" = "copy_to_clipboard";
      # "ctrl+v" = "paste_from_clipboard";
    # };
  };
}
