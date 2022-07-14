{ pkgs, ... }:

{
  home.packages = with pkgs; with bat-extras; [
    batdiff
    batgrep
    batman
    batwatch
    prettybat
  ];
  
  programs.bat = {
    enable = true;
    config.theme = "Dracula";
  };
}