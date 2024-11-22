{
  pkgs,
  ...
}:
{
  # Here add programs
  environment.systemPackages = with pkgs; [
    gcc
    python3
    typescript
    nodejs
    nodePackages.npm
    gnumake

    ranger
    vim
    neovim
    fzf

    vscode
    # nix language server
    nixd

    godot_4
    sdkmanager
    jdk17

    vesktop
    spotify

    krabby
    tree
    wget
    killall
    eza
    git
    htop
    lm_sensors

    lxqt.lxqt-policykit
    
    unzip
    unrar

    libnotify
    ripgrep
    brightnessctl
    upower
    bluez

    hyprshot
  ];
}