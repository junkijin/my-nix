{
  description = "Junki's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nix-darwin,
      home-manager,
      nixvim,
      ...
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Junkis-MacBook-Pro
      darwinConfigurations."Junkis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              nixvim.homeModules.nixvim
            ];
            home-manager.users."junkijin" = ./home.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
