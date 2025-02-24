{
  self,
  pkgs,
  username,
  osConfig,
  lib,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
with lib;
{
  # This Code is contained in home-manager.user.${username} = {<code>}  
  # Take a look at flake.nix
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home = { 
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    pointerCursor = {
      package = mkDefault osConfig.style.cursor.package;
      name = mkDefault osConfig.style.cursor.name;
      size = mkDefault osConfig.style.cursor.size;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor = {
        enable = true;
        size = osConfig.style.cursor.size;
      };
    };
  };

  imports = [
    ../../config/hypr
    ../../config/kitty
    ../../config/fish 
    ../../config/ranger
    ../../config/vscode
  ];

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
