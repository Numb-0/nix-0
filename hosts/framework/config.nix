{
  inputs,
  pkgs,
  host,
  username,
  options,
  config,
  nixos-hardware,
  ...
}:
let
  inherit (import ./variables.nix)
    keyboardLayout
    timeZone
    defaultLocale
    extraLocale;
in
{
  # This file contains all the nixos modules configutations of the modules not included using the flake {ags, stylix, ...}
  imports = [
    # Hardware Tweaks for amd and such
    nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware.nix
    ./users.nix
    ./packages.nix
    ./stylix.nix
    ../../modules/style.nix
    ../../modules/amd-drivers.nix
  ];

  # Custom Modules
  style = {
    enable = true;
    scheme = "gruvbox";
  };


  # drivers = {
    # amdgpu.enable = false;
  # };

  # Add nixos-hardware config!!!

  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  boot = {
    # This is for OBS Virtual Cam Support
    kernelModules = [
      "v4l2loopback"
      "acpi_call"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback
      config.boot.kernelPackages.acpi_call
    ];
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

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      # settings = {
      #   General = {
      #     Enable = "Source,Sink,Media,Socket";
      #   };
      # };
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = host;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      # Opened ports for Lynx
      allowedTCPPorts = [ 80 443 1025 3000];
      allowedUDPPortRanges = [
        { from = 1025; to = 1025; }
        { from = 3000; to = 3001; }
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };

  time.timeZone = timeZone;

  i18n = {
    defaultLocale = defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = extraLocale;
      LC_IDENTIFICATION = extraLocale;
      LC_MEASUREMENT = extraLocale;
      LC_MONETARY = extraLocale;
      LC_NAME = extraLocale;
      LC_NUMERIC = extraLocale;
      LC_PAPER = extraLocale;
      LC_TELEPHONE = extraLocale;
      LC_TIME = extraLocale;
    };
  };

  programs = {
    ssh.startAgent = true;
    adb.enable = true;
    firefox.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged programs

        # Needed for android godot build
        aapt
      ];
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      # extraPackages = with pkgs; [
      #   bumblebee
      #   glxinfo
      #   libglvnd
      #   SDL2
      #   glibc
      # ];
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
  };

  virtualisation.docker = {
    enable = true;
    #storageDriver = "btrfs";
  };


  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    configPackages = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  console.keyMap = keyboardLayout;

  security = {
    rtkit.enable = true;
  };

  services = {
    fwupd.enable = true;
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    upower = {
      enable = true;
    };
    auto-cpufreq = {
      enable = false;
        settings = {
        battery = {
           governor = "powersave";
           turbo = "never";
        };
        charger = {
           governor = "performance";
           turbo = "auto";
        };
      };
    };
    printing = {
      enable = true;
      drivers = [
        pkgs.cups-brother-dcp1610wlpr
      ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    getty.autologinUser = username;
    gvfs.enable = true;
    fstrim.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };

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
