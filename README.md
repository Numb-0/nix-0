<div align="center">   
    <img src="./docs/assets/nix0_banner.svg">
    <br>
</div>


# Nix-0
A simple ***❄ NixOs configuration ❄*** using [**Hyrpland**](https://github.com/hyprwm/Hyprland) and [**Ags**](https://github.com/Aylur/ags) themed in Catpuccin Macchiato

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
# The  variables.nix File
This file contains variables that are used to set options in different part of the configuration like hyprland, git
> [!WARNING] 
> Not all the settings are covered by variables, some options have been manually written in config.nix!