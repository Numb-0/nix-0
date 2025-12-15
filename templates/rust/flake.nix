{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let 
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in
  {
    devShells."x86_64-linux".default = pkgs.mkShell {
      packages = with pkgs; [
        cargo 
        rustc
        rustfmt
        clippy
        rust-analyzer
      ];
      env.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };

    packages."x86_64-linux".default = pkgs.rustPlatform.buildRustPackage {
      name = "testrust";
      src = ./.;
      buildInputs = [ pkgs.glib ];
      nativeBuildInputs = [ pkgs.pkg-config ];
      cargoLock.lockFile = ./Cargo.lock;
    };
  };
}
