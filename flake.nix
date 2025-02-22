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
    # not using this till it has the features kitty has
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };
    nix-0-shell.url = "path:./config/ags";  #builtins.getFlake "ags";
  };
  outputs =
    { self, nixpkgs, home-manager, stylix, nix-0-shell, ... }@inputs:
    let
      system = "x86_64-linux";
      # Here choose the host configuration
      host = "nixos";
      username = "cosix";
    in
    builtins.trace "Self inputs: ${builtins.toString ./.}"
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
