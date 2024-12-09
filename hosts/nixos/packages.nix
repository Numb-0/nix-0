{
  pkgs,
  ...
}:
{
  environment.variables = { EDITOR = "code";};
  # Here add programs
  environment.systemPackages = with pkgs; [
    gcc
    cmake
    python3
    typescript
    nodejs
    nodePackages.npm
    gnumake

    neovim
    ranger
    fzf
    fd

    vscode
    # nix language server
    nixd

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
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      roboto
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
