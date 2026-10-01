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
    ../../config/chromix
  ];

  # programs.ssh = {
  #   enable = true;
  #   addKeysToAgent = "yes";
  # };
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    hyprcursor.enable = true;
  };

  # Starts with graphical-session.target (see morph-shell's README)
  programs.morph-shell.enable = true;

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
      init = { defaultBranch = "main"; };
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

  # Installed here rather than system-wide so chromix themes them. The
  # shell integrations stay off: fish keeps its own abbreviations and
  # key bindings.
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };
  programs.eza = {
    enable = true;
    enableFishIntegration = false;
  };
  programs.fastfetch.enable = true;
  programs.imv.enable = true;
  programs.vim.enable = true;
  programs.prismlauncher.enable = true;
  programs.vscode.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
    };
  };

  # adw-gtk3 draws GTK 3 apps from libadwaita's named colours, which is
  # what chromix's gtk.css redefines.
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    font = {
      name = "Roboto";
      size = 11;
    };
    # GTK 4 apps are libadwaita, which reads chromix's colours directly.
    gtk4.theme = null;
    # Papirus with its folders in the theme's colour, built by chromix.
    iconTheme = {
      name = "Papirus-Chromix";
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

  # Fusion draws with the palette qtct hands it, which chromix sets; a
  # style with its own colours, such as adwaita-dark, would ignore it.
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    qt5ctSettings.Appearance = {
      style = "Fusion";
      icon_theme = "Papirus-Chromix";
    };
    qt6ctSettings.Appearance = {
      style = "Fusion";
      icon_theme = "Papirus-Chromix";
    };
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
