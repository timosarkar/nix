{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nethack

  shellHook = ''
    nethack
  '';
}
