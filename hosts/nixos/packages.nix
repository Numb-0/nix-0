{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gcc
    cmake
    python3
    php
    typescript
    nodejs
    nodePackages.npm
    gnumake

    nixfmt-rfc-style
    nil

    neovim
    fzf
    fd

    godot_4
    sdkmanager
    jdk17

    unityhub
    dotnetCorePackages.dotnet_8.sdk
    icu

    vesktop
    spotify
    obs-studio
    prismlauncher
    aseprite

    (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
         # List package dependencies here
       ];
    })

    fastfetch
    krabby
    tree
    wget
    killall
    eza
    git
    htop
    lm_sensors
    imv

    lxqt.lxqt-policykit
    patchelf

    unzip
    unrar
    staruml

    libnotify
    ripgrep
    brightnessctl
    upower
    bluez

    hyprpicker
    hyprshot
    wl-clipboard
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      symbola
      monocraft
      noto-fonts
      nerd-fonts.jetbrains-mono
      roboto
    ];
    fontconfig = {
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
