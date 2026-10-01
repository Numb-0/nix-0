# Nix & NixOS Cheatsheet

## System Management

### Updating System

Update channels (if not using flakes):

```bash
sudo nix-channel --update
```

Update flakes and rebuild:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos --update
```

For SSH flake inputs:

```bash
nixos-rebuild switch --flake .#nixos --show-trace --use-remote-sudo
```

### Channels

List available channels:

```bash
sudo nix-channel --list
```

### Cleaning Generations

List system generations:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

Garbage collection:

```bash
nix-collect-garbage --delete-old
nix-collect-garbage --delete-generations 1 2 3
sudo nix-collect-garbage -d
```

### Cleaning Boot

```bash
sudo /run/current-system/bin/switch-to-configuration boot
```

## Package Management

### Checking Dependencies

Check why a system depends on a specific package:

```bash
nix why-depends /run/current-system /nix/store/path_to_source/pkgs/development/libraries/libxml2
```

### Searching for Libraries

Search in nix-store:

```bash
find /nix/store -name "libSDL2-2.0.so*"
```

## Flakes

### Basic Flake Commands

Show flakes in repo or local directory:

```bash
nix flake show github:Numb-0/nix-0
```

Update flakes:

```bash
nix flake update
```

### Flake Templates

Create a new directory using a template:

```bash
nix flake new -t github:Numb-0/nix-0#pythonVenv directory_name
```

Initialize current directory with a template (or create new flake.nix without `-t`):

```bash
nix flake init -t github:Numb-0/nix-0#pythonVenv
```

### Development Shells

After initializing a flake, access the development shell:

```bash
nix develop
```

### Installing Flakes

Add the flake to inputs and reference in modules:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mock-local-flake.url = "path:./relative/path/from/flake"; # <-- Local flake reference
    mock-git-file-flake.url = "git+file:///home/user/some-repo"; # <-- Local git checkout
    mock-ssh-flake.url = "git+ssh://git@github.com/Numb-0/nix-0-shell?ref=main"; # <-- SSH-based flake
  };

  outputs = { self, nixpkgs, home-manager, mock-local-flake, ... }@inputs: {
    nixosConfigurations."«hostname»" = nixpkgs.lib.nixosSystem { # <-- Replace «hostname» with your actual hostname
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # NixOS modules exported by the flake
        home-manager.nixosModules.home-manager
        mock-local-flake.nixosModules.default
        {
          home-manager = {
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit self username inputs host; };
            # Home Manager modules exported by the flake, applied to every user
            sharedModules = [ inputs.mock-local-flake.homeManagerModules.default ];
            users.${username} = import ./hosts/${host}/home.nix;
          };
          # Here add the overlays
        }
      ];
    };
  };
}
```

Then enable the options the modules provide, e.g. `programs.morph-shell.enable = true;` in both the NixOS config and `home.nix` (this repo does exactly this with `morph-shell`).

## Advanced Configuration

### NixPkgs Overlays

Apply patches or modifications to packages:

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

### Package Overrides

Override package options:

```nix
(prismlauncher.override {
    jdks = [ jdk17 ]; # or jdk21
})
```

### Version Pinning

#### Method 1: Using nixpkgs Flake Revision

1. Specify a new input nixpkgs with the correct version package revision
2. Add the input in the specialArgs
3. Add the package specifying where to get it from

```nix
inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dbeaver.url = "github:NixOS/nixpkgs/1cb1c02a6b1b7cf67e3d7731cbbf327a53da9679#";
}

# --- In specialArgs ---
specialArgs = { 
    inherit self system inputs username host nixos-hardware nixpkgs-dbeaver;
    pkgs-dbeaver = import nixpkgs-dbeaver {
        inherit system;
        config.allowUnFree = true;
    };
};

# --- In packages ---
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

#### Method 2: Using Package Tags

1. Specify tag version in the package URL
2. Pin the nixpkgs version so that the pinned package uses the correct dependencies

```nix
quickshell = {
    url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=refs/tags/v0.2.1";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

### Packaging Prebuilt Binaries (buildFHSEnv)

Some apps are only shipped as prebuilt Linux binaries, like a `.deb`, an AppImage or a tarball. Unity Hub is one example. These binaries expect a normal Linux folder layout, with libraries in `/usr/lib` and so on. NixOS doesn't have that layout, so they fail with missing `.so` errors. The fix is to unpack the upstream package without compiling anything, then run the binary inside a `buildFHSEnv`. That gives the program a sandbox that looks like a regular distro, with the libraries you list. Anything the program starts, such as the Unity Editors that Hub downloads, runs in the same sandbox, so their libraries go in the list too.

How it fits together (shortened from `unhub.nix`):

1. `fetchurl` downloads the `.deb` and `dpkg` (in `nativeBuildInputs`) unpacks it. Set `dontConfigure`/`dontBuild` because there's nothing to compile.
2. `buildFHSEnv` builds the sandbox. `targetPkgs` holds the tools and data the app calls at runtime. `multiPkgs` holds the shared libraries, and it also gets 32-bit versions.
3. `installPhase` copies the files to `$out` and replaces the upstream launcher with a `makeWrapper` that runs the real binary inside the sandbox. It also fixes the absolute `/opt/...` path in the `.desktop` file.

```nix
{ stdenv, fetchurl, dpkg, makeWrapper, buildFHSEnv, extraPkgs ? pkgs: [ ], extraLibs ? pkgs: [ ] }:

stdenv.mkDerivation rec {
  pname = "unityhub";
  version = "3.13.0";
  src = fetchurl { url = "https://hub-dist.unity3d.com/.../unityhub-amd64-${version}.deb"; sha256 = "..."; };

  nativeBuildInputs = [ dpkg makeWrapper ];

  fhsEnv = buildFHSEnv {
    pname = "${pname}-fhs-env";
    inherit version;
    runScript = "";
    targetPkgs = pkgs: with pkgs; [ xdg-utils gsettings-desktop-schemas ] ++ extraPkgs pkgs; # tools
    multiPkgs = pkgs: with pkgs; [ gtk3 nss alsa-lib libglvnd vulkan-loader ] ++ extraLibs pkgs; # libraries
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    mv opt/ usr/share/ $out
    # Replace upstream launcher: run the real binary inside the FHS env
    makeWrapper ${fhsEnv}/bin/${pname}-fhs-env $out/opt/unityhub/unityhub \
      --add-flags $out/opt/unityhub/unityhub-bin --argv0 unityhub
    mkdir -p $out/bin
    ln -s $out/opt/unityhub/unityhub $out/bin/unityhub
    substituteInPlace $out/share/applications/unityhub.desktop \
      --replace-fail /opt/unityhub/unityhub $out/opt/unityhub/unityhub
  '';
}
```

Use it, and add any missing libraries without editing the package:

```nix
environment.systemPackages = [
  (pkgs.callPackage ./unhub.nix {
    extraLibs = pkgs: [ pkgs.libxcrypt-legacy ]; # -> multiPkgs
    extraPkgs = pkgs: [ pkgs.dotnet-sdk ];       # -> targetPkgs
  })
];
```

To find which package provides a missing library, see [Searching for Libraries](#searching-for-libraries). Unfree apps like this one also need `nixpkgs.config.allowUnfree = true;`.
