{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ags }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      ags = ags.packages.${system}.default;
      shell = ags.lib.bundle {
        inherit pkgs;
        # This Points to this Flake root directory 
        src = self;
        name = "nix-0-shell";
        entry = "app.ts";
        gtk4 = true;

        # additional libraries and executables to add to gjs' runtime
        extraPackages = [
          pkgs.fzf
          ags.packages.${system}.io
          ags.packages.${system}.apps
          ags.packages.${system}.apps
          ags.packages.${system}.battery
          ags.packages.${system}.hyprland
          ags.packages.${system}.wireplumber
          ags.packages.${system}.bluetooth
          ags.packages.${system}.network
          ags.packages.${system}.notifd
          ags.packages.${system}.tray
          ags.packages.${system}.mpris
          ags.packages.${system}.cava
          ags.packages.${system}.powerprofiles
        ];
      };
    };

    # nix develop shell
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        # includes astal3 astal4 astal-io by default
        (ags.packages.${system}.default.override { 
          extraPackages = [
            # cherry pick packages
          ];
        })
      ];
    };
  };
}