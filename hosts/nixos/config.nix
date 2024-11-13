{
  inputs,
  pkgs,
  host,
  username,
  options,
  ...
}:
let
  inherit (import ./variables.nix) keyboardLayout;
in
{
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/local-hardware-clock.nix
  ];

  # Bootloader
  boot = {
    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    # Needed for Razer
    kernelParams = [ "intremap=off" "splash" "nvidia_drm.modeset=1" ];
    #extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Styling Options
  stylix = {
    enable = true;
    targets = {
      fish.enable = false;
    };
    image = ../../config/wallpapers/squares.png;
    # Macchiato
    base16Scheme = {
      base00 = "24273a"; # base
      base01 = "1e2030"; # mantle
      base02 = "363a4f"; # surface0
      base03 = "494d64"; # surface1
      base04 = "5b6078"; # surface2
      base05 = "cad3f5"; # text
      base06 = "f4dbd6"; # rosewater
      base07 = "b7bdf8"; # lavender
      base08 = "ed8796"; # red
      base09 = "f5a97f"; # peach
      base0A = "eed49f"; # yellow
      base0B = "a6da95"; # green
      base0C = "8bd5ca"; # teal
      base0D = "8aadf4"; # blue
      base0E = "c6a0f6"; # mauve
      base0F = "f0c6c6"; # flamingo
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      serif = {
        package = pkgs.roboto-serif;
        name = "Roboto-serif";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 12;
        popups = 12;
      };
    };
  };

  # Extra Module Options
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "PCI:00:02:0";
    nvidiaBusID = "PCI:58:00:0";
  };
  drivers.intel.enable = true;
  local.hardware-clock.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = host;
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  programs = {
    firefox.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    #virt-manager.enable = false;
    steam = {
      enable = true;
      #gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = true;
  };

  # Here add program without configurations
  environment.systemPackages = with pkgs; [
    vim
    vscode
    nixd
    krabby
    wget
    killall
    eza
    git
    htop
    lxqt.lxqt-policykit
    lm_sensors
    unzip
    unrar
    libnotify
    ripgrep
    brightnessctl
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      material-icons
    ];
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    getty.autologinUser = username;
  };

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Optimization settings and garbage collection automation
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  console.keyMap = "${keyboardLayout}";

  system.stateVersion = "24.05"; 
}
