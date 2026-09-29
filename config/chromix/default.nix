{
  lib,
  ...
}:
let
  wallpapers = builtins.path {
    path = ../wallpapers;
    name = "wallpapers";
  };
  # Every wallpaper is a theme, named after its file.
  name = file: lib.removeSuffix ".jpg" (lib.removeSuffix ".png" file);

  # Picked per wallpaper after comparing what matugen makes of each; a
  # wallpaper not listed here gets the defaults.
  tuning = {
    # Olive leaves: content stays on the seed, with a green tertiary.
    forest.type = "scheme-content";
    # The first colour is the red stripe; the yellow one is gruvbox, and
    # rainbow keeps the surfaces neutral grey like the background.
    gruv = {
      colorIndex = 1;
      type = "scheme-rainbow";
    };
    # The seed is the grey-blue triangle; vibrant makes it the lavender
    # and blue of the other triangles over blue-tinted surfaces.
    squares.type = "scheme-vibrant";
    # Iridescent: fruit-salad turns the grey-lilac seed into cyan with a
    # lavender tertiary, and keeps it apart from squares.
    swirl.type = "scheme-fruit-salad";
  };
in
{
  programs.chromix = {
    enable = true;

    themes = lib.mapAttrs' (
      file: _:
      lib.nameValuePair (name file) (
        { image = "${wallpapers}/${file}"; } // tuning.${name file} or { }
      )
    ) (builtins.readDir wallpapers);

    default = {
      theme = "gruv";
      mode = "dark";
    };

    # Not managed by programs.neovim: config/nvim loads the file itself.
    targets.neovim.enable = true;

    # Sourced by fish_prompt, so running shells follow a switch on
    # their next prompt.
    targets.fish = {
      enable = true;
      template = ./templates/fish.fish;
      output = "fish/colors.fish";
    };
  };
}
