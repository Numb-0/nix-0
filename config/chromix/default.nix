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

  # Every theme is tonal-spot, the variant M3 tunes its roles for: the
  # others push chroma past the wallpaper (vibrant), put the container
  # at the seed's own tone (content, fidelity), or make the primary and
  # secondary containers one colour (fruit-salad). Themes are told apart
  # by the seed instead, picked per wallpaper with
  # `matugen image <file> --show-source-colors`; a wallpaper not listed
  # here seeds from its most dominant colour.
  tuning = {
    # The first colour is the red stripe; the yellow one is gruvbox.
    gruv.colorIndex = 1;
    # The pale blue band rather than the grey-lilac, which would seed
    # the same blue-lavender as squares.
    swirl.colorIndex = 2;
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
