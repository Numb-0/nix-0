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
