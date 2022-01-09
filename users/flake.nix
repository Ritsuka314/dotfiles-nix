{
  description = "Home manager configuration";

  inputs = rec {
    # TODO hopefully flake can be stable one day
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO hopefully no need to use nightly build one day
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { home-manager, nixpkgs, neovim-nightly-overlay, ... }:
  let
    overlays = [neovim-nightly-overlay.overlay];
    mkuser = isWSL: home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          username = "richard";
          homeDirectory = "/home/richard";
          stateVersion = "21.05"; # why do I have to put this here???
          configuration = (import ./home.nix) {inherit overlays isWSL;};
        };
  in rec{
    homeConfigurations = {
      nixos = mkuser false;
      wsl = mkuser true;
    };
    richard = homeConfigurations.richard.activationPackage;
  };
}
