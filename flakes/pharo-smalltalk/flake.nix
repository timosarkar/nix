{
  description = "pharo via get.pharo.org";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "pharo";
        version = "latest";

        src = pkgs.fetchurl {
          url = "https://get.pharo.org";
          sha256 = "ccf2b303da56a3d33fa97d1b135cb2716251ce1e49f995579d0a1758366f4865";
        };

        unpackPhase = "true";

        installPhase = ''
          mkdir -p $out/bin
          cp $src $out/bin/pharo-launcher
          chmod +x $out/bin/pharo-launcher
          echo "to remove: rm -rf pharo* Pharo*"
        '';
      };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/pharo-launcher";
      };
    };
}
