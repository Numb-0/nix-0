{
  self,
  pkgs,
  username,
  lib,
  ...
}:
let
  inherit (import ../../modules/core/variables.nix) gitUsername gitEmail;
in
{
  # This Code is contained in home-manager.user.${username} = {<code>}
  # Take a look at flake.nix
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  imports = [
    ../../config/hypr
    ../../config/kitty
    ../../config/fish
    ../../config/ranger
    ../../config/ghostty
  ];

  # programs.ssh = {
  #   enable = true;
  #   addKeysToAgent = "yes";
  # };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
      };
      push = { autoSetupRemote = true; };
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      proc_gradient = false;
      rounded_corners = false;
      presets = "cpu:0:braille,mem:0:braille,proc:0:braille,net:0:braille,disks:0:braille";
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    configFile = {

    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Papirus-Dark";
        };
      };
    };

    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Papirus-Dark";
        };
      };
    };
    };
  };

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

  qt = {
    enable = true;
    # platformTheme.name = "qtct";
  };

  # Scripts
  home.packages = [
    (import ../../scripts/setup_nvim.nix { inherit pkgs self; })
    (import ../../scripts/toggle_monitor.nix { inherit pkgs; })
  ];
}
