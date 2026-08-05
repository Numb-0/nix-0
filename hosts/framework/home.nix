{
  self,
  pkgs,
  username,
  lib,
  config,
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
    ../../config/ghostty
    ../../config/yazi
  ];

  # programs.ssh = {
  #   enable = true;
  #   addKeysToAgent = "yes";
  # };
  home.pointerCursor.enable = true;

  programs.git = {
    enable = true;
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
      format = "ssh";
    };
    settings = {
      user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
      };
      commit = {
        gpgSign = true;
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
      setSessionVariables = true;
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
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "adwaita-dark";
  };

  # Hot-reload nvim config: symlink ~/.config/nvim → ~/nix-0/config/nvim
  # After one rebuild, any edit to the source is immediately live in Neovim.
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-0/config/nvim";

  # Scripts
  home.packages = [
    (import ../../scripts/toggle_monitor.nix { inherit pkgs; })
  ];
}
