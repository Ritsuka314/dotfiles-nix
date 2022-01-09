{ config, pkgs, lib, colorscheme, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 10;
      font_family       = "DejaVu Sans Mono Nerd Font Complete Mono"; # DejaVuSansMono Nerd Font
      bold_font         = "DejaVu Sans Mono Bold Nerd Font Complete Mono";
      italic_font       = "DejaVu Sans Mono Oblique Nerd Font Complete Mono";
      bold_italic_font  = "DejaVu Sans Mono Bold Oblique Nerd Font Complete Mono";

      shell = "zsh";
      scrollback_lines = 10000;
      input_delay = 1;

      foreground = "${colorscheme.fg-primary}";
      background = "${colorscheme.bg-primary}";

      color0 = "${colorscheme.black}";
      color1 = "${colorscheme.red}";
      color2 = "${colorscheme.green}";
      color3 = "${colorscheme.yellow}";
      color4 = "${colorscheme.blue}";
      color5 = "${colorscheme.magenta}";
      color6 = "${colorscheme.cyan}";
      color7 = "${colorscheme.white}";
      color8 = "${colorscheme.bright-black}";
      color9 = "${colorscheme.bright-red}";
      color10 = "${colorscheme.bright-green}";
      color11 = "${colorscheme.bright-yellow}";
      color12 = "${colorscheme.bright-blue}";
      color13 = "${colorscheme.bright-magenta}";
      color14 = "${colorscheme.bright-cyan}";
      color15 = "${colorscheme.bright-white}";
    };
  };
}
