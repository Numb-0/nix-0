# nix-0

![nix-0 logo](./docs/assets/nix-0.svg)

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-cyan?logo=hyprland)](https://hyprland.org)
[![License](https://img.shields.io/github/license/Numb-0/nix-0)](LICENSE)

A minimal ***❄ NixOS configuration ❄*** using [**Hyprland**](https://github.com/hyprwm/Hyprland) and [**Morph Shell**](https://github.com/Numb-0/morph-shell) (a Quickshell-based desktop shell), with colours generated from the wallpaper by [**Chromix**](https://github.com/Numb-0/chromix) (Material You themes via matugen).

## 📁 Project Structure

```bash
nix-0/
├── flake.nix              # Main flake configuration
├── hosts/
│   ├── default/           # Shared host configuration
│   └── framework/         # Host-specific config (Framework laptop)
├── modules/
│   ├── core/              # Core system modules (packages, users)
│   ├── rice/              # Fonts and fontconfig defaults
│   └── graphics/          # GPU drivers (AMD, Nvidia, Intel)
├── config/                # Application configs
│   ├── chromix/           # Chromix themes, targets and custom templates
│   ├── wallpapers/        # Wallpapers (each one is a Chromix theme)
│   ├── hypr/              # Hyprland, hyprlock, hyprpaper, hypridle
│   ├── fish/              # Fish shell
│   ├── kitty/             # Kitty terminal
│   ├── nvim/              # Neovim configuration
│   └── ...
├── scripts/               # Helper scripts
├── templates/             # Flake templates (Python venv, etc.)
└── docs/                  # Documentation
```

## 🚀 Installation

### 1. Clone the repository

Clone in the Home directory or else nvim configuration symlink will not work:

```bash
git clone https://github.com/Numb-0/nix-0.git ~/nix-0
```

### 2. Navigate to directory

```bash
cd ~/nix-0
```

### 3. Generate Hardware Config and replace it

```bash
nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware.nix
```

### 4. Apply flake configuration

```bash
nixos-rebuild switch --flake .#<hostname> (if using the ssh flake add --remote-sudo )
```

> [!TIP]
> Make sure you have NixOS installed and flakes enabled before proceeding. If you encounter any issues, refer to the NixOS documentation. 📚

## 🐚 Shell

The desktop shell is [Morph Shell](https://github.com/Numb-0/morph-shell), imported as a flake input and wired in through its two modules:

- **NixOS module** (`morph-shell.nixosModules.default` in `flake.nix`, enabled with `programs.morph-shell.enable` in `hosts/<hostname>/config.nix`) — installs the package, fonts, UPower and PipeWire.
- **Home Manager module** (`homeManagerModules.default`, added via `home-manager.sharedModules`, enabled in `hosts/<hostname>/home.nix`) — autostarts the shell with `graphical-session.target`.

Shell panels are driven over IPC, e.g. `morph-shell ipc call launcher toggle`.

## 🎨 Theming

Colours come from [Chromix](https://github.com/Numb-0/chromix), imported as a flake input and enabled through its Home Manager module (`chromix.homeManagerModules.default`, configured in `config/chromix/default.nix`).

- **Every wallpaper is a theme**: each file in `config/wallpapers/` becomes a theme named after it (`gruv.png` → `gruv`). Drop in a new image and rebuild to get a new theme.
- **Seed colours**: all themes use the M3 *tonal-spot* variant and are told apart by their seed colour. A wallpaper seeds from its most dominant colour unless overridden in the `tuning` set (pick an index with `matugen image <file> --show-source-colors`).
- **Default**: `gruv` in dark mode.
- **Targets**: Hyprland borders/shadows, hyprpaper, hyprlock, Neovim (via `mini.base16`), GTK (`adw-gtk3` for GTK 3, libadwaita for GTK 4) and Fish (custom template in `config/chromix/templates/fish.fish`, re-read on every prompt).

Switch themes at runtime without rebuilding:

```bash
chromix list                 # declared themes, current one marked
chromix set jap dark         # switch theme (and optionally mode)
chromix mode toggle          # flip between dark and light
chromix wall <image>         # generate a theme from any image and switch to it
```

Fonts are set in `modules/rice/fonts.nix` (Roboto, Noto Serif, JetBrains Mono, Noto Color Emoji).

## ⌨️ Keybinds

### General

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Return</kbd> | Toggle fullscreen |
| <kbd>Super</kbd> + <kbd>T</kbd> | Launch terminal |
| <kbd>Super</kbd> + <kbd>E</kbd> | Launch browser |
| <kbd>Super</kbd> + <kbd>Q</kbd> | Close focused window |
| <kbd>Super</kbd> + <kbd>M</kbd> | Exit Hyprland |
| <kbd>Super</kbd> + <kbd>W</kbd> | Toggle floating |
| <kbd>Super</kbd> + <kbd>F</kbd> | Toggle pseudo tiling |
| <kbd>Super</kbd> + <kbd>J</kbd> | Toggle split layout |
| <kbd>Super</kbd> + <kbd>H</kbd> | Screenshot region (grim + slurp, annotate in satty) |

### Focus & Mouse

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>←</kbd> | Focus window left |
| <kbd>Super</kbd> + <kbd>→</kbd> | Focus window right |
| <kbd>Super</kbd> + <kbd>↑</kbd> | Focus window up |
| <kbd>Super</kbd> + <kbd>↓</kbd> | Focus window down |
| <kbd>Super</kbd> + <kbd>LMB</kbd> | Move window (drag) |
| <kbd>Super</kbd> + <kbd>RMB</kbd> | Resize window (drag) |

### Morph Shell

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>A</kbd> | Toggle App Launcher |

### Workspaces

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>1–9</kbd> | Switch to workspace |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1–9</kbd> | Move window to workspace |
| <kbd>Super</kbd> + <kbd>Scroll Up</kbd> | Switch to next workspace |
| <kbd>Super</kbd> + <kbd>Scroll Down</kbd> | Switch to previous workspace |
| <kbd>Super</kbd> + <kbd>S</kbd> | Toggle special workspace |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> | Move window to special workspace |

### Media & Hardware

| Keys | Action |
| :--- | :--- |
| <kbd>XF86AudioRaiseVolume</kbd> | Volume up |
| <kbd>XF86AudioLowerVolume</kbd> | Volume down |
| <kbd>XF86AudioMute</kbd> | Toggle mute |
| <kbd>XF86MonBrightnessUp</kbd> | Brightness up |
| <kbd>XF86MonBrightnessDown</kbd> | Brightness down |
| <kbd>XF86AudioPlay</kbd> / <kbd>XF86AudioPause</kbd> | Play/Pause media |
| <kbd>XF86AudioNext</kbd> | Next track |
| <kbd>XF86AudioPrev</kbd> | Previous track |
| Lid close | Disable internal display |
| Lid open | Enable internal display |

## Credits

- [NixOS](https://nixos.org) - The declarative Linux distribution
- [Hyprland](https://hyprland.org) - Dynamic tiling Wayland compositor
- [Chromix](https://github.com/Numb-0/chromix) - Wallpaper-driven theming, built on [matugen](https://github.com/InioX/matugen)
- [Home Manager](https://github.com/nix-community/home-manager) - User environment management
- [Morph Shell](https://github.com/Numb-0/morph-shell) - Desktop shell, built on [Quickshell](https://quickshell.org)
