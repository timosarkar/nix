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

    # local files to include by home-manager
    snippets = builtins.readFile ./files/snippets/all.snippets;
    # aliases = builtins.readFile ./files/aliases;
    markdown = builtins.readFile ./files/snippets/markdown.snippets;
    snippets-snippets = builtins.readFile ./files/snippets/snippets.snippets;
    html = builtins.readFile ./files/snippets/html.snippets;
  in {
    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = { 
          inherit snippets;
          inherit snippets-snippets;
          inherit markdown;
          inherit html;
          # inherit aliases;
        };
      };
    };
  };
}
