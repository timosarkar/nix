{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.bun
    pkgs.nodejs_22
  ];

  shellHook = ''
  '';
}
