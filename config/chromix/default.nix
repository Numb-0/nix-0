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
in
{
  programs.chromix = {
    enable = true;

    themes = lib.mapAttrs' (
      file: _: lib.nameValuePair (name file) { image = "${wallpapers}/${file}"; }
    ) (builtins.readDir wallpapers);

    default = {
      theme = "gruvbox";
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

    # hyprlock reads its config on every start: nothing to reload.
    targets.hyprlock = {
      enable = true;
      template = ./templates/hyprlock.conf;
      output = "hyprlock/colors.conf";
    };

    # The whole hyprpaper config, so the wallpaper is the theme's image.
    targets.hyprpaper = {
      enable = true;
      template = ./templates/hyprpaper.conf;
      output = "hyprpaper/hyprpaper.conf";
      reload = "systemctl --user try-restart hyprpaper.service";
    };
  };
}
