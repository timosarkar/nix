{
  description = "Simple C++ project using LLVM and CMake";
  # nix develop
  # nix build
  # ./result/bin/project
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "project";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.cmake ];
          buildInputs = [ pkgs.llvmPackages_16.llvm pkgs.llvmPackages_16.clang ];

          cmakeFlags = [];

          installPhase = ''
            mkdir -p $out/bin
            cp project $out/bin/
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.cmake
            pkgs.llvmPackages_16.llvm
            pkgs.llvmPackages_16.clang
          ];

          shellHook = ''
            echo "Welcome to your C++ dev shell with LLVM and CMake!"
          '';
        };
      });
}
