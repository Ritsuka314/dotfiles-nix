{ pkgs, ... }:

{
  home.packages = with pkgs; with bat-extras; [
    bat
    batdiff
    batgrep
    batman
    batwatch
    prettybat
  ];
}