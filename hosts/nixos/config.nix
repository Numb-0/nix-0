{
  inputs,
  pkgs,
  host,
  username,
  options,
  config,
  ...
}:
let
  inherit (import ./variables.nix) keyboardLayout;
in
{
  # This file contains all the nixos modules configutations of the modules not included using the flake {ags, stylix, ...}
  imports = [
    ./hardware.nix
    ./users.nix
    ./stylix.nix
    ./packages.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
  ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Bootloader
  boot = {
    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" "acpi_call" ];
    # Needed for Razer
    kernelParams = [ "button.lid_init_state=open" "intremap=off" "quiet" "splash" "nvidia_drm.modeset=1" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback config.boot.kernelPackages.acpi_call ];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # This is for the keyboard
    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
  };

  # Extra Module Options based on machine structure
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "PCI:00:02:0";
    nvidiaBusID = "PCI:58:00:0";
  };
  drivers.intel.enable = true;


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

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages

      # Needed for android godot build
      aapt
    ];
  };

  programs = {
    adb.enable = true;
    firefox.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
      };
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      /* extraPackages = with pkgs; [
        bumblebee
        glxinfo
        libglvnd
        SDL2
        glibc
      ]; */
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  users = {
    mutableUsers = true;
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
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  console.keyMap = "${keyboardLayout}";

  security = {
    rtkit.enable = true;
    pam.services.wayland.enableGnomeKeyring = true;
  };

  # Services to start
  services = {
    gnome.gnome-keyring.enable = true;
    mysql = {
        enable = true;
        package = pkgs.mariadb;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 20; 
       STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
    upower = {
      enable = true;
    };
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ]; 
          settings = {
            main = {  
              capslock = "layer(control)"; 
            };
            otherlayer = {};
          };
          extraConfig = ''
            [main]
            y = z
            z = y
          '';
        };
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
    gvfs.enable=true;
    fstrim.enable = true;
  };

  # Bluetooth Support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

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

  system.stateVersion = "24.05";
}
