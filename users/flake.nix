{
  description = "Home manager configuration";

  inputs = rec {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
  { home-manager, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    mkuser = isWSL: home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ((import ./home.nix) {inherit isWSL;})
            {
              home = {
                username = "ritsuka";
                homeDirectory = "/home/ritsuka";
                stateVersion = "22.11";
              };
            }
          ];
        };
  in rec{
    homeConfigurations = {
      nixos = mkuser false;
      wsl = mkuser true;
    };
    # richard = homeConfigurations.richard.activationPackage;
  };
}
