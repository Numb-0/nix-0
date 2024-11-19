{
  pkgs,
  username,
  config,
  lib,
  system,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  programs.home-manager.enable = true;
  home = { 
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  # Import Program Configurations
  imports = [ 
    ../../config/ags
    ../../config/hypr
    ../../config/kitty
    ../../config/fish 
  ];

  # Nvim dotfiles
  home.file.".config/nvim" = {
    source = ../../config/nvim;
    recursive = true;
  };

  # Place Files Inside Home Directory
  # TODO make a an array of string containing wallpapers file names and pass them to hyprpaper
  home.file."Pictures/wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  stylix.targets.hyprland.enable = false;  

  # Gtk
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Qt
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  home.packages = [
    (import ../../scripts/setup_ags.nix { inherit pkgs config; })
  ];
}
