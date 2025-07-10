{
  pkgs,
  pkgs-dbeaver,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gnumake
    gcc
    cmake
    python3
    
    php
    php83Packages.composer
    ghostscript

    typescript
    nodejs
    nodePackages.npm
    yarn

    nixfmt-rfc-style
    nil

    neovim
    fzf
    fd
    
    blender
    godot_4
    sdkmanager
    jdk21
    jdk17

    # unityhub
    dotnetCorePackages.dotnet_8.sdk
    icu
    
    dbeaver-bin
    thunderbird
    chromium
    # vesktop
    discord-canary
    spotify
    obs-studio
    prismlauncher
    aseprite
    vscode
    # code-cursor
    obsidian

    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.it_IT
    hunspellDicts.en_US

    (lutris.override {
      extraLibraries = pkgs: [
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
    udiskie

    lxqt.lxqt-policykit

    unzip
    unrar

    ripgrep
    brightnessctl
    libnotify

    hyprpicker
    hyprshot
    wl-clipboard

    jq
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      symbola
      monocraft
      noto-fonts
      jetbrains-mono
      roboto
    ];
    fontconfig = {
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "JetBrains Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
