{
  description = "nix flake to manage my dotfiles with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    username = if builtins.getEnv "USER" != "" then builtins.getEnv "USER" else "root";
    PHPsnippets = builtins.readFile ./snippets/php.snippets;
  in {
    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = { inherit PHPsnippets; };
      };
    };
  };
}
