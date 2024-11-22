{
  programs.kitty = {
    enable = true;
    extraConfig = 
    ''
    # Font
    font_family      auto     #JetBrainsMono Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto

    # Show underline in auto-completition
    modify_font underline_thickness 150%
    modify_font underline_position +1

    hide_window_decorations yes
    draw_minimal_borders no
    window_border_width 0
    window_margin_width 0
    window_padding_width 0
    background_opacity 0.8

    # Preferences
    confirm_os_window_close 0
    allow_remote_control yes

    # KeyBinds
    map ctrl+c copy_to_clipboard
    map ctrl+v paste_from_clipboard
    '';
  };
}