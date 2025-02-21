<div align="center"><img src="./docs/assets/nix0_banner.svg"></div>


# nix-0
A simple ***❄ NixOs configuration ❄*** using [**Hyrpland**](https://github.com/hyprwm/Hyprland) and [**Ags**](https://github.com/Aylur/ags) themed using Catpuccin Macchiato

# Installation
1. **Clone the repository** in the home directory or where you want:
```bash
git clone https://github.com/Numb-0/nix-0.git ~/nix-0
```
2. **Navigate to directory**
```bash
cd ~/nix-0
```
3. **Apply flake configuration**
```bash
sudo nixos-rebuild switch --flake .#nixos
```
# Ags
The ags application is quite bounded with Hyprland so if you are using another WM most of the features won't work.\
For example i'm using the Hyprland keybinds to hide/show different windows of the ags application.

# Personalization
Some of the configuration values are in the [variables.nix](hosts/nixos/variables.nix) file.
The file contains variables that are used to set options in different part of the configuration like hyprland, git and others.

> [!WARNING] 
> Not all the settings are covered by variables, some options have been manually written in [config.nix](hosts/nixos/config.nix)!
