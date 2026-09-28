{
  description = "nix-0 Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chromix = {
      url = "git+ssh://git@github.com/Numb-0/chromix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    morph-shell = {
      url = "git+ssh://git@github.com/Numb-0/morph-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs =
    { self, nixpkgs, home-manager, nixos-hardware, morph-shell, ... }@inputs:
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
            home-manager.nixosModules.home-manager
            morph-shell.nixosModules.default
            {
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
              home-manager = { 
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit self username inputs host; };
                sharedModules = [
                  inputs.morph-shell.homeManagerModules.default
                  inputs.chromix.homeManagerModules.default
                ];
                users.${username} = import ./hosts/${host}/home.nix;
              };
            }
          ];
        };
      };
    };
}
