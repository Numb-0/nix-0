{
  description = "nix-0 Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Local checkout until the Nix modules are pushed; then switch to
    # "github:Numb-0/morph-shell".
    morph-shell = {
      url = "git+file:///home/cosix/morph-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs =
    { self, nixpkgs, home-manager, nixos-hardware, stylix, quickshell, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "framework";
      username = "cosix";
    in
    {
      templates = import ./templates;
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit self system inputs username host nixos-hardware;
          };
          modules = [
            ./hosts/${host}/config.nix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            inputs.morph-shell.nixosModules.default
            {
              # Package, fonts, UPower and PipeWire; autostart is left to
              # the Home Manager module below.
              programs.morph-shell.enable = true;

              # Temporary workaround for picosvg tests failing
              # nixpkgs.overlays = [
              #   (final: prev: {
              #     pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
              #       (python-final: python-prev: {
              #         picosvg = python-prev.picosvg.overridePythonAttrs (oldAttrs: {
              #           doCheck = false;
              #         });
              #       })
              #     ];
              #   })
              # ];
              environment.systemPackages = [
                quickshell.packages.${system}.default
              ];
              home-manager = { 
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit self username inputs host; };
                sharedModules = [ inputs.morph-shell.homeManagerModules.default ];
                users.${username} = import ./hosts/${host}/home.nix;
              };
            }
          ];
        };
      };
    };
}
