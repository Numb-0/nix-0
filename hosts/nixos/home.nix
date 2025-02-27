{
  self,
  pkgs,
  username,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
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
    ../../config/vscode
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    /* matchBlocks = {
        "github.com" = {
          identityFile = "~/.ssh/id_ed25519";
          user = "git";
        };
      }; */
  };

  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
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
    # style.name = "adwaita-dark";
    # platformTheme.name = "gtk4";
  };

  # Scripts
  home.packages = [
    (import ../../scripts/setup_nvim.nix { inherit pkgs self; })
  ];
}
