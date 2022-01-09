{ pkgs, lib,... }:

{
  fonts.fontconfig.enable = true; # needs fontconfig to manager ttc fonts
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
    noto-fonts-cjk
    (stdenv.mkDerivation rec {
      name = "starfont";
      version = "1.0";
      meta = {
        description = "StarFont";
        license = lib.licenses.free;
        platforms = lib.platforms.all;
      };
      fontfile = copyPathsToStore [
        ./Astro.ttf
      ];
      buildCommand = ''
        for font in ${lib.concatMapStringsSep " " toString fontfile}; do
          install -m444 -Dt $out/share/fonts/truetype $font
        done
      '';
    })
  ];
}
