{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        paths = with pkgs; lib.makeLibraryPath [
          # this creates paths to given packages
        ];

        testScript = pkgs.writeShellScriptBin "testScript" ''
          echo "This is test script!!"
          echo the test env var is $TESTVAR 
          echo il pathadas = $USER
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            testScript
          ];
          
          # This is how you can set env variables for the given shell
          TESTVAR = "/path/or/anything/you/want";
          
          # if you want to access already defined env variables in your system you need to run
          # nix develop --impure
          USER="${builtins.getEnv "HOME"}:pathAggiunto";

          postShellHook = ''
            # you can add commands to execute after shell creation
          '';
        };
      }
    );
}
