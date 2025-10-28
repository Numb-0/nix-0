## Nix & Nix Flakes Cheatsheet
### Checking dependencies of a build
```nix why-depends /run/current-system /nix/store/path_to_source/pkgs/development/libraries/libxml2```
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

### NixPkgs Overlay
```nix
nixpkgs.overlays = [
  (final: prev: {
    lxqt = prev.lxqt.overrideScope (lfinal: lprev: {
      libqtxdg = lprev.libqtxdg.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or []) ++ [
          (prev.fetchpatch {
            name = "cmake-fix-build-with-Qt-6.10.patch";
            url = "https://github.com/lxqt/libqtxdg/commit/b01a024921acdfd5b0e97d5fda2933c726826e99.patch";
            hash = "sha256-njpn6pU9BHlfYfkw/jEwh8w3Wo1F8MlRU8iQB+Tz2zU=";
          })
        ];
      });
    });
  })
];
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

### Pinning a pkg version to using nixpkgs flake revision
1. Specify a new input nixpkgs with the correct version pkg revision
2. Add the input in the specialArgs (maybe it can be done differently)
3. Add the pkg specifying where to get it from

```nix
inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dbeaver.url = "github:NixOS/nixpkgs/1cb1c02a6b1b7cf67e3d7731cbbf327a53da9679#";
}
# --- Code... ---
specialArgs = { 
    inherit self system inputs username host nixos-hardware nixpkgs-dbeaver;
    pkgs-dbeaver = import nixpkgs-dbeaver {
        inherit system;
        config.allowUnFree = true;
    };
};
# --- Packages ---
{
    pkgs,
    pkgs-dbeaver,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        neovim
        # ...
        pkgs-dbeaver.dbeaver-bin
    ]
}
```
