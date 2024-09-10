{
  description = "my-flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixvim
    , ...
    } @ inputs:
    let
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        homeserver = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./users/homeserver
            ./modules/podman
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.homeserver.imports = [
                ./users/homeserver/dots.nix
              ];
            }
          ];
        };
      };
    };
}
