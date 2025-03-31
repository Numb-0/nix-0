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

