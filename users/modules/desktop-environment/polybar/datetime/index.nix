{ pkgs, ... }:

let
  lua = pkgs.lua5_4;
in
{
  home.packages = [
    lua
  ];

  home.file.".config/polybar/datetime/datetime.lua" = {
    text = ''
      #!${lua}/bin/lua
      
      ${builtins.readFile ./datetime.lua}
    '';
    executable = true;
  };
}
