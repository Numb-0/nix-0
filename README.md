# nix-0

![nix-0 logo](./docs/assets/nix-0.svg)

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-cyan?logo=hyprland)](https://hyprland.org)
[![License](https://img.shields.io/github/license/Numb-0/nix-0)](LICENSE)

A minimal ***❄ NixOS configuration ❄*** using [**Hyprland**](https://github.com/hyprwm/Hyprland) and [**Quickshell**](https://quickshell.org), with applications styled by [**Stylix**](https://github.com/danth/stylix).

![quickshell screenshot](https://raw.githubusercontent.com/Numb-0/frame-shell/main/assets/qs_1.png)

## ✨ Features

- 🎨 **Theming** - Consistent styling across apps with Stylix (Gruvbox, Catppuccin)
- 🖥️ **Hyprland** - Modern Wayland compositor with smooth animations
- 🐚 **Quickshell** - Custom shell widgets and panels
- 📦 **Flakes** - Reproducible and declarative configuration
- 🏠 **Home Manager** - User environment management
- 🎮 **Gaming Ready** - Steam, Gamemode, and optimizations included

## 📁 Project Structure

```
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

## 🎨 Themes

Available colorschemes in `modules/rice/options.nix`:

| Theme | Preview |
| :--- | :--- |
| **Gruvbox** | 🟤🟠🟡🟢🔵🟣 |
| **Catppuccin Macchiato** | 🔴🟠🟡🟢🔵🟣 |

Change theme in `hosts/<hostname>/config.nix`:
```nix
style = {
  enable = true;
  scheme = "gruvbox"; # or "catppuccin"
};
```

## 📦 Included Software

| Category | Applications |
| :--- | :--- |
| **Terminal** | Kitty, Fish shell |
| **Editor** | Neovim, VS Code |
| **Browser** | Firefox, Chromium |
| **File Manager** | Nautilus, Yazi |
| **Media** | VLC, Spotify |
| **Development** | Git, Docker, Node.js, Python |
| **Gaming** | Steam, Lutris, Gamemode |
| **Creative** | Blender, GIMP, Godot |

## 🚀 Installation

### 1. Clone the repository

Clone in the home directory or where you want:

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

## Personalization

To customize the configuration, you can modify the values in the **[variables.nix](modules/core/variables.nix)** file.  
This file contains variables that are used to set options across different parts of the configuration, such as:

- **Hyprland**
- **Git**
- And more...

> [!WARNING]
> **Not all settings are controlled by variables!**  
> Options are also defined in the **[default config.nix](hosts/default/config.nix)** file, so make sure to check there as well. 🛠️
> Since NixOs configurations specify also Hardware setting it's better to create a new Host and use it as your selected one in the main **[flake.nix](flake.nix)**
> To create your personal Hardware nix file refer to [step 3](#3-generate-hardware-config-and-replace-it)

## ⌨️ Keybinds

### General

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Q</kbd> | Close focused window |
| <kbd>Super</kbd> + <kbd>T</kbd> | Launch terminal |
| <kbd>Super</kbd> + <kbd>E</kbd> | Launch browser |
| <kbd>Super</kbd> + <kbd>W</kbd> | Toggle floating |
| <kbd>Shift</kbd> + <kbd>Enter</kbd> | Toggle fullscreen |
| <kbd>Super</kbd> + <kbd>H</kbd> | Screenshot region |

### Quickshell

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>A</kbd> | Toggle App Launcher |
| <kbd>Super</kbd> + <kbd>D</kbd> | Toggle Dashboard |
| <kbd>Super</kbd> + <kbd>X</kbd> | Toggle Power Actions |

### Workspaces

| Keys | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>1-9</kbd> | Switch to workspace |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1-9</kbd> | Move window to workspace |
| <kbd>Super</kbd> + <kbd>S</kbd> | Toggle special workspace |

### Media & Hardware

| Keys | Action |
| :--- | :--- |
| <kbd>XF86AudioRaiseVolume</kbd> | Volume up |
| <kbd>XF86AudioLowerVolume</kbd> | Volume down |
| <kbd>XF86AudioMute</kbd> | Toggle mute |
| <kbd>XF86MonBrightnessUp</kbd> | Brightness up |
| <kbd>XF86MonBrightnessDown</kbd> | Brightness down |
| <kbd>XF86AudioPlay</kbd> | Play/Pause media |
| <kbd>XF86AudioNext</kbd> | Next track |
| <kbd>XF86AudioPrev</kbd> | Previous track |

## 🙏 Acknowledgments

- [NixOS](https://nixos.org) - The declarative Linux distribution
- [Hyprland](https://hyprland.org) - Dynamic tiling Wayland compositor
- [Stylix](https://github.com/danth/stylix) - System-wide theming for NixOS
- [Home Manager](https://github.com/nix-community/home-manager) - User environment management
- [Quickshell](https://quickshell.org) - Shell widget framework
- [Catppuccin](https://github.com/catppuccin) & [Gruvbox](https://github.com/morhetz/gruvbox) - Colorschemes

## 📄 License

This project is open source. Feel free to use and modify it for your own NixOS setup!

