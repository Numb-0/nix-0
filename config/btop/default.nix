{
  programs.btop = {
    enable = true;
    settings = {
      # color_theme is set by stylix
      theme_background = false;
      proc_gradient = false;
      rounded_corners = false;
      presets = "cpu:0:braille,mem:0:braille,proc:0:braille,net:0:braille,disks:0:braille";
    };
  };
}