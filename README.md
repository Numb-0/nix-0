# nix-0

![nix-0 logo](./docs/assets/nix-0.svg)

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-cyan?logo=hyprland)](https://hyprland.org)
[![License](https://img.shields.io/github/license/Numb-0/nix-0)](LICENSE)

A minimal ***❄ NixOS configuration ❄*** using [**Hyprland**](https://github.com/hyprwm/Hyprland) and [**Quickshell**](https://quickshell.org), with applications styled by [**Stylix**](https://github.com/danth/stylix).

<!-- ![quickshell screenshot](https://raw.githubusercontent.com/Numb-0/frame-shell/main/assets/qs_1.png) -->

## 📁 Project Structure

```bash
nix-0/
├── flake.nix              # Main flake configuration
├── hosts/
│   ├── default/           # Shared host configuration
│   └── framework/         # Host-specific config (Framework laptop)
├── modules/
│   ├── core/              # Core system modules (packages, users)
│   ├── rice/              # Theming (Stylix, colorschemes)
│   └── graphics/          # GPU drivers (AMD, Nvidia, Intel)
├── config/                # Application configs
│   ├── hypr/              # Hyprland, hyprlock, hypridle
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
| <kbd>Super</kbd> + <kbd>H</kbd> | Screenshot region |

### Focus & Mouse

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>←</kbd> | Focus window left |
| <kbd>Super</kbd> + <kbd>→</kbd> | Focus window right |
| <kbd>Super</kbd> + <kbd>↑</kbd> | Focus window up |
| <kbd>Super</kbd> + <kbd>↓</kbd> | Focus window down |
| <kbd>Super</kbd> + <kbd>LMB</kbd> | Move window (drag) |
| <kbd>Super</kbd> + <kbd>RMB</kbd> | Resize window (drag) |

### Quickshell

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>A</kbd> | Toggle App Launcher |
| <kbd>Super</kbd> + <kbd>C</kbd> | Toggle Mixer |
| <kbd>Super</kbd> + <kbd>D</kbd> | Toggle Dashboard |
| <kbd>Super</kbd> + <kbd>X</kbd> | Toggle Power Actions |

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
- [Stylix](https://github.com/danth/stylix) - System-wide theming for NixOS
- [Home Manager](https://github.com/nix-community/home-manager) - User environment management
- [Quickshell](https://quickshell.org) - Shell widget framework
- [Catppuccin](https://github.com/catppuccin) & [Gruvbox](https://github.com/morhetz/gruvbox) - Colorschemes
