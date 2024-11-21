{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.bash
  ];

  shellHook = ''
    curl https://get.modular.com | MODULAR_AUTH=mut_a09238af19e94653a9b696832b1454e3 sh -
    modular install mojo
  '';
}
