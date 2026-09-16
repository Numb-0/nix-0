{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # ── Build tools ───────────────────────────────────────────────────────────
    gnumake
    gcc
    cmake

    # ── Languages & runtimes ──────────────────────────────────────────────────
    python3
    nodejs
    # npm
    yarn
    typescript
    php
    php83Packages.composer
    ghostscript

    # ── JVM / Android ─────────────────────────────────────────────────────────
    jdk17
    jdk21
    sdkmanager
    android-tools

    # ── .NET ──────────────────────────────────────────────────────────────────
    dotnetCorePackages.dotnet_8.sdk
    icu

    # ── Language servers & formatters ─────────────────────────────────────────
    nil
    nixfmt
    lua-language-server
    typescript-language-server
    pyright

    # ── Editor & terminal tools ───────────────────────────────────────────────
    vim
    neovim
    tree-sitter
    fzf
    fd
    ripgrep

    # ── Creative / 3D ─────────────────────────────────────────────────────────
    blender
    godot_4
    gimp
    gimp3
    obs-studio
    orca-slicer
    lycheeslicer
    # aseprite

    # ── Applications ──────────────────────────────────────────────────────────
    vlc
    pavucontrol
    thunderbird
    chromium
    # google-chrome
    discord-canary
    spotify
    desmume
    prismlauncher
    # lutris
    dbeaver-bin
    vscode
    # vscodium
    # obsidian
    claude-code
    filezilla

    # ── Office & documents ────────────────────────────────────────────────────
    libreoffice-qt-stable
    hunspell
    hunspellDicts.it_IT
    hunspellDicts.en_US

    # ── File management ───────────────────────────────────────────────────────
    nautilus
    imv
    udiskie

    # ── CLI utilities ─────────────────────────────────────────────────────────
    fastfetch
    krabby
    tree
    wget
    eza
    htop
    lm_sensors
    jq

    # ── Archives & USB ────────────────────────────────────────────────────────
    unzip
    zip
    unrar
    usbutils

    # ── System utilities ──────────────────────────────────────────────────────
    killall
    brightnessctl
    libnotify
    playerctl

    # ── Wayland / Hyprland ────────────────────────────────────────────────────
    hyprpicker
    grim
    slurp
    wl-clipboard
    satty
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
