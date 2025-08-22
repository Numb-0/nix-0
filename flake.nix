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
            {
              # nixpkgs.config.permittedInsecurePackages = [
              #   "libxml2-2.13.8"
              # ];
              environment.systemPackages = [
                quickshell.packages.${system}.default
              ];
              home-manager = { 
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit self username inputs host; };
                users.${username} = import ./hosts/${host}/home.nix;
              };
            }
          ];
        };
      };
    };
}
