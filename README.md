## Nixos configuration

## Instructions
### Installation
1. git clone the repo in $HOME or use github flake feature
## Nix Cheatsheet
### Removing unused pkgs
```nix
nix-collect-garbage 
```
### Searching for libs in nix-store
```nix
find /nix/store -name "libSDL2-2.0.so*" 
```
### Cleaning generations
```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
nix-collect-garbage  --delete-old
nix-collect-garbage  --delete-generations 1 2 3
sudo nix-collect-garbage -d
```
### Cleaning boot
```
sudo /run/current-system/bin/switch-to-configuration boot
```
