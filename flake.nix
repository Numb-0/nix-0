{
  description = "nix-0 Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:danth/stylix";
    };
    # Have to specify ref cause default is master
    zero-shell.url = "git+ssh://git@github.com/Numb-0/zero-shell?ref=main";
  };
  
  outputs =
    { self, nixpkgs, home-manager, stylix, zero-shell, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "nixos";
      username = "cosix";
    in
    {
      templates = import ./templates;
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self system inputs username host; };
          modules = [
            ./hosts/${host}/config.nix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              environment.systemPackages = [
                zero-shell.packages.${system}.shell
                zero-shell.packages.${system}.ags
                zero-shell.packages.${system}.astal
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
