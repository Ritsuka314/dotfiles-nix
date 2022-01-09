{ config, pkgs, lib, colorscheme, ... }:

{
  imports = [
    ./fonts.nix
    ./xresources.nix
    ./kitty.nix
    ./polybar/index.nix
  ];

  home.packages = with pkgs; [
    gnome.nautilus

    gyre-fonts # TeX Gyre

    # colorscheme dracula
    dracula-theme
    moka-icon-theme
    # colorscheme onedark
    # TODO

    # system tray
    gnome.networkmanagerapplet
    volumeicon
  ];

  programs.rofi = {
    enable = true;
    package = with pkgs; rofi.override {
      plugins = [ rofi-calc rofi-file-browser ];
    };
  };
  home.file.".config/rofi/colors.rasi".text = ''
    * {
      accent: ${colorscheme.accent-primary};
      background: ${colorscheme.bg-primary};
      foreground: ${colorscheme.fg-primary};
    }
  '';
  home.file.".config/rofi/grid.rasi".source = ./rofi/grid.rasi;
  home.file.".config/rofi/sysmenu.rasi".source = ./rofi/sysmenu.rasi;

  gtk = {
    enable = true;
    font.name      = "TeX Gyre Heros 10";
    iconTheme.name = colorscheme.gtk-icon-name;
    theme.name     = colorscheme.gtk-name;
  };

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = pkgs.writeText "xmonad.hs" ''
        ${builtins.readFile ./xmonad/config.hs}

        home = "/home/richard"

        -- Dracula color scheme
        myFocusedBorderColor = "#BD93F9" -- accent-primary = blue;
        myNormalBorderColor = "#44475a" -- bg-primary-bright = bright-black;
    '';
    };
  };

  # services.barrier.client.enable = true;
}
