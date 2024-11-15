## Nixos configuration
## Nix Cheatsheet
### Removing unused pkgs
```nix
nix-collect-garbage 
```
### Searching for libs in nix-store
```nix
find /nix/store -name "libSDL2-2.0.so*" 
```
