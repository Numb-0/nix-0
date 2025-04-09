{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages = pkgs.python3Packages;
        ldPaths = with pkgs; lib.makeLibraryPath [
          # Pkgs to add to LD_LIBRARY_PATH 
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonPackages.python
            pythonPackages.venvShellHook
            # Add any pkgs you need in your shell
          ];

          venvDir = "./.venv";

          postVenvCreation = ''
            unset SOURCE_DATE_EPOCH
          '';

          postShellHook = ''
            unset SOURCE_DATE_EPOCH
            export LD_LIBRARY_PATH="${ldPaths}:$LD_LIBRARY_PATH"
          '';
        };
      }
    );
}
