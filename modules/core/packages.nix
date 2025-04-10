{
  pkgs,
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
    typescript
    nodejs
    nodePackages.npm
    yarn

    nixfmt-rfc-style
    nil

    neovim
    fzf
    fd

    godot_4
    sdkmanager
    jdk17
    jdk21

    unityhub
    dotnetCorePackages.dotnet_8.sdk
    icu
    
    thunderbird
    chromium
    # vesktop
    discord-canary
    spotify
    obs-studio
    prismlauncher
    # aseprite
    vscode
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

    # libnotify
    ripgrep
    brightnessctl

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
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
