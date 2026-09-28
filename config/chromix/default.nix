{
  osConfig,
  lib,
  ...
}:
let
  # Every wallpaper is a theme, named after its file; the one set as
  # the wallpaper is where chromix starts.
  name =
    path:
    lib.removeSuffix ".jpg" (
      lib.removeSuffix ".png" (builtins.unsafeDiscardStringContext (baseNameOf path))
    );
in
{
  programs.chromix = {
    enable = true;

    themes = lib.listToAttrs (
      map (path: lib.nameValuePair (name path) { image = path; }) osConfig.style.wallpaper.paths
    );

    default = {
      theme = name osConfig.style.wallpaper.path;
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
  };
}
