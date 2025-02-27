{
  description = "nix-0 Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # not using this till it has the features kitty has
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };
    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:danth/stylix";
    };
    # Using local flake
    #nix-0-shell.url = "path:./config/ags";
    nix-0-shell.url = "git+ssh://git@github.com/Numb-0/nix-0-shell.git?ref=main";
  };
  
  outputs =
    { self, nixpkgs, home-manager, stylix, nix-0-shell, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "nixos";
      username = "cosix";
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self system inputs username host; };
          modules = [
            ./hosts/${host}/config.nix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              environment.systemPackages = [
                #ghostty.packages.x86_64-linux.default
                nix-0-shell.packages.${system}.shell
                nix-0-shell.packages.${system}.ags
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
