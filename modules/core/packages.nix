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
    pavucontrol
    lutris
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
    orca-slicer
    # lxqt.lxqt-policykit
    # obsidian
    
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
    playerctl

    hyprpicker
    hyprshot
    wl-clipboard

    jq

    android-tools
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      jetbrains-mono
      roboto
      material-symbols
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      # useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Serif CFK JP" ];
        sansSerif = [ "Roboto" "Noto Sans CJK JP" ];
        monospace = [ "JetBrains Mono" "Noto Sans Mono CJK JP" ];
        emoji = [ "Noto Color Emoji" ];
      };
      hinting = {
        enable = true;
        style = "full";
      };
      antialias = true;
      subpixel = {
        rgba = "rgb";
      };
    };
  };
}
