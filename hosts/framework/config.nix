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
  inherit (import ../../modules/core/variables.nix)
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
    ./stylix.nix
    ../../modules/core
    ../../modules/style.nix
  ];

  # Custom Modules
  style = {
    enable = true;
    scheme = "gruvbox";
  };

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
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = host;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      # Opened ports for Lynx & other applications
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
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ]; 
    };
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
    pki.certificates = 
    [''
      -----BEGIN CERTIFICATE-----
      MIIEIjCCAoqgAwIBAgIRAINhJ4MMD0N6r6p2vNfcqhIwDQYJKoZIhvcNAQELBQAw
      bTEeMBwGA1UEChMVbWtjZXJ0IGRldmVsb3BtZW50IENBMSEwHwYDVQQLDBhjb3Np
      eEBmcmFtZXdvcmsgKE51bWItMCkxKDAmBgNVBAMMH21rY2VydCBjb3NpeEBmcmFt
      ZXdvcmsgKE51bWItMCkwHhcNMjUwNDE4MTExMjI4WhcNMjcwNzE4MTExMjI4WjBM
      MScwJQYDVQQKEx5ta2NlcnQgZGV2ZWxvcG1lbnQgY2VydGlmaWNhdGUxITAfBgNV
      BAsMGGNvc2l4QGZyYW1ld29yayAoTnVtYi0wKTCCASIwDQYJKoZIhvcNAQEBBQAD
      ggEPADCCAQoCggEBAMJDbUshoUlISkhneR6DVdKBnID8FgiB70OGrIb0OBh+h62T
      e+S9hFxGeXf4xyujNBvJbDdAU+6VrB9gh+qj7qkeiFSe8A3S/d77FBWsc8gSz4yw
      OiM6hnGTv5lTIHo+gkdDPXjt1ehaQpoe/URFolhviMPLBP0sX1HfJdWQuBmH02Te
      0RC2PTiPb7pY7GzouHcarWudM8d8veeG1VhptxEiZYziT6L7pqcXCxLG3Y19ijiG
      xKlRFCkNuY+LJGCzh3SetJ98IyFmuJuKj16HM2xgwddmvCCRxOsQ/4abBDNYFjm9
      P5wTW7qLl+NLpCk8x8Xezd3tngMQ9H7tGqehtJUCAwEAAaNeMFwwDgYDVR0PAQH/
      BAQDAgWgMBMGA1UdJQQMMAoGCCsGAQUFBwMBMB8GA1UdIwQYMBaAFHP+qAWT7Afi
      HGslGX4FT3X+mqBYMBQGA1UdEQQNMAuCCWxvY2FsaG9zdDANBgkqhkiG9w0BAQsF
      AAOCAYEAX6JkOxTjDDdsPE3uVB0Y2YsYepSqOiI41L/fr7QD8U6UCYQclzMA5b5S
      mRyKDuPL8NjtVaEC5WbunYmpwFh/hQMZLDDzqfTDTfiFzIH9+Fxf4NIvAQZTKjDa
      u3/NYCg78tcyQ6NheaXPYEjpCPBp2uRoUXXDKT+d4aqQY25GDIlkHt/QORos4F6T
      XHQC5h37MxuCaEU0Aqibb/7t9BAxiJjJMFmgT5/w3YhfAvX+uN9CzJXadHbM9gNP
      eZKEAbLnIyfuPlj6RkQ35UFV8b2iISVOiAkE3knWJAVZuUQMJKeXEJumb/Pkv9d7
      7DTqzpxK3FBf4OGNEDsJQVAacWBB5m0oNk0fjAdZJpn0e4dmp9N1RPq2an395rKl
      Hym0TqsRwYwPNZyZS2n+HPT5kIlV/MRvtJ0V/4IC2woVNzJ+xRiNJVIl99QQT5kC
      pX5eLF436/y7yUfmY39XI5qYKV2XySAABoAMzQdkzyPVnbcLsoCIlxSFs4NHxs5a
      BQu87lb8
      -----END CERTIFICATE-----
    ''];
    rtkit.enable = true;
  };

  services = {
    samba = {
      enable = true;
    };
    # fprintd.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" "webgirs"];
      ensureUsers =  [
        {
          name = "webgirs";
          ensureDBOwnership = true;
        }
      ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        host    all       all       127.0.0.1/32 md5
        host    all       all       ::1/128      md5
      '';
      initialScript = pkgs.writeText "postgres-init" ''
        ALTER ROLE webgirs WITH PASSWORD 'webgir';
      '';
      extensions = ps : with ps; [ postgis ];
    };
    power-profiles-daemon.enable = true;
    upower.enable = true;
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
