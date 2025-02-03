{
  pkgs,
  username,
  config,
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
    (import ../../scripts/setup_ags.nix { inherit pkgs config; })
    (import ../../scripts/setup_nvim.nix { inherit pkgs config; })
  ];
}
