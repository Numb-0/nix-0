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
2. nix flake update (probs the same as under here?)
3. sudo nixos-rebuild switch --flake .#nixos --update
```
### Channels
```
sudo nix-channel --list 

```

### Installing flakes

What you have to do is adding the flake in the inputs and add the entry in the modules or where it needs to be used
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mock-local-flake.url = "path:./relative/path/from/flake"; # <-- Local flake reference
    mock-ssh-flake.url = "git+ssh://git@github.com/Numb-0/nix-0-shell?ref=main"; # <-- SSH-based flake
  };

  outputs = { nixpkgs, stylix, ... }: {
    nixosConfigurations."«hostname»" = nixpkgs.lib.nixosSystem { # <-- Replace «hostname» with your actual hostname
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix
        # Add modules here
        # home-manager.nixosModules.home-manager
      ];
    };
  };
}
```
if you have an ssh flake input use `nixos-rebuild switch --flake .#nixos --show-trace --use-remote-sudo`

## Nix Flakes Cheatsheet

### Show flakes in repo or local directory
```bash
nix flake show github:Numb-0/nix-0    
```
### Create a directory using the given template
```bash
nix flake new -t github:Numb-0/nix-0#pythonVenv webgirs
```

### Initialize the Current Directory with Your Template or creates a new flake.nix if used without -t
```bash
nix flake init -t github:Numb-0/nix-0#pythonVenv
```
### After the flake is copied use `nix develop` to access the development shell 
