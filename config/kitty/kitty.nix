{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    #themeFile = "Catppuccin-Macchiato";
    font = {
      name = "JetBrainsMono Nerd Font Mono";
    };
    settings = {
      include = "./theme.conf";
      background_opacity = 0.8;
      confirm_os_window_close = 0;
      cursor_trail = 3;
    };
    keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}