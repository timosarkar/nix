{
  description = "my nix configurations for my MacBook Pro M4";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: 
    let
      username = "timo";
      hostname = "Mac";
      architecture = "aarch64-darwin";
    in {
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      system = architecture;
      pkgs = import nixpkgs { system = architecture; };
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        ({ pkgs, ... }: {
          programs.zsh = {
            enable = true;
            shellInit = "";
          };

          environment.shells = [pkgs.zsh];
          environment.loginShell = pkgs.zsh;
          environment.systemPath = ["/run/current-system/sw/bin"];
          
          users.users.${username} = {
            shell = pkgs.zsh;
            home = "/Users/${username}";
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { };
            users.${username}.imports = [ ./modules/home-manager ];
          };
        })
      ];
    };
  };
}
