## Nixos configuration

## Installation
1. git clone the repo in $HOME and rebuild :)
## Nix Cheatsheet
### Removing unused pkgs
```
nix-collect-garbage 
```
### Searching for libs in nix-store
```
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
### Updating system
```
1. sudo nix-channel --update
2. nix flake update
3. sudo nixos-rebuild switch --flake .#nixos --update
```

### Channels
```
sudo nix-channel --list 

```

### Installing flakes
Here we take stylix as example
What you have to do is adding the flake in the inputs and add the entry in the modules
```
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, stylix, ... }: {
    nixosConfigurations."«hostname»" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ stylix.nixosModules.stylix ./configuration.nix ];
    };
  };
}
```
