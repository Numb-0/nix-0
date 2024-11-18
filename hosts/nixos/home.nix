{
  pkgs,
  username,
  inputs,
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
    inputs.ags.homeManagerModules.default 
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

  programs.ags = {
    enable = true;
    # Default path ~/.config/ags
    configDir = null;

    # Additional packages to add to gjs's runtime
    extraPackages = [
      inputs.ags.packages.${pkgs.system}.io 
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.bluetooth
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.tray
    ];
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
  # Scripts
  /* home.packages = [
    (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../../scripts/task-waybar.nix { inherit pkgs; })
    (import ../../scripts/squirtle.nix { inherit pkgs; })
    (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ../../scripts/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ../../scripts/web-search.nix { inherit pkgs; })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ../../scripts/screenshootin.nix { inherit pkgs; })
    (import ../../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
  ]; */
}
