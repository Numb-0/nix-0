{
  self,
  pkgs,
  username,
  config,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # This File is contained in home-manager.user.${username} = {<file>}  
  # Take a look at flake.nix

  # Home Manager Settings
  programs.home-manager.enable = true;
  home = { 
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  # Import Programs Configurations
  imports = [ 
    ../../config/hypr
    ../../config/kitty
    ../../config/fish 
  ];

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Btop
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

  # Create XDG Dirs
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };  
  
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
    # Was gtk3
    platformTheme.name = "gtk4";
  };

  # Scripts
  home.packages = [
    (import ../../scripts/setup_nvim.nix { inherit pkgs config self; })
  ];
}
