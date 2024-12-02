{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = 
    ''
    # Font
    font_family      auto
    bold_font        auto
    italic_font      auto
    bold_italic_font auto

    # General
    background_opacity 0.8
    cursor_trail 3
    allow_remote_control yes
    confirm_os_window_close 0
    placement_strategy top
    text_composition_strategy legacy

    # Keybindings
    map ctrl+c copy_to_clipboard
    map ctrl+v paste_from_clipboard
    '';
  };
}
