{
  description = "Home manager configuration";

  inputs = rec {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
  { home-manager, nixpkgs, ... }:
  let
    mkuser = isWSL: home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          username = "richard";
          homeDirectory = "/home/richard";
          # stateVersion = "22.05"; # why do I have to put this here???
          configuration = (import ./home.nix) {inherit isWSL;};
        };
  in rec{
    homeConfigurations = {
      nixos = mkuser false;
      wsl = mkuser true;
    };
    richard = homeConfigurations.richard.activationPackage;
  };
}
