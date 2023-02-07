{ isWSL }: # for partial application

{ config, pkgs, lib, colorscheme, ... }:

{
  imports = [
    ./modules/cli-misc.nix
    #
    ./modules/bat-and-friends.nix
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/zsh.nix
  ] ++
  ( if !isWSL
    then [
      ./modules/desktop-environment/index.nix
    ]
    else []
  );

  _module.args = {
    colorscheme = (import ./colorschemes/dracula.nix);
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "ritsuka";
    homeDirectory = "/home/ritsuka";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "22.05";
}
