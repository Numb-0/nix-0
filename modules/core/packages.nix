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
    ghostscript

    typescript
    nodejs
    nodePackages.npm
    yarn

    nixfmt-rfc-style
    nil

    nautilus
    neovim
    fzf
    fd
    
    blender
    godot_4
    sdkmanager
    jdk21
    jdk17

    dotnetCorePackages.dotnet_8.sdk
    icu
    
    vlc
    gimp
    dbeaver-bin
    thunderbird
    chromium
    discord-canary
    spotify
    obs-studio
    prismlauncher
    # aseprite
    vscode
    # lxqt.lxqt-policykit
    obsidian
    
    gimp3
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.it_IT
    hunspellDicts.en_US

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

    unzip
    zip
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
      noto-fonts
      noto-fonts-color-emoji
      jetbrains-mono
      roboto
      material-symbols
      nerd-fonts.jetbrains-mono
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
