{ pkgs, ... }:

{
  #home.packages = with pkgs; [
    # (vim_configurable.customize {
    #   name = "vim";
    #   #does not seem necessary to explicitly load vim-nix
    #   #vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix ];
    #   vimrcConfig.customRC = ''
    #     " Normally we use vim-extensions. If you want true vi-compatibility
    #     " remove change the following statements
    #     set nocompatible                " Use Vim defaults instead of 100% vi compatibility
    #     set backspace=indent,eol,start  " more powerful backspacing

    #     " Now we set some defaults for the editor
    #     set history=50                  " keep 50 lines of command line history
    #     set ruler                       " show the cursor position all the time

    #     " Suffixes that get lower priority when doing tab completion for filenames.
    #     " These are files we are not likely to want to edit or read.
    #     set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

    #     " enable syntax hilighting
    #     syntax enable
        
    #     " replace tabs
    #     set tabstop=2
    #     set shiftwidth=2
    #     set expandtab
    #   '';
    # })
  # ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
      ]))
    ]; 
    extraConfig = ''
      packadd nvim-treesitter
      packadd vim-nix

      " enable syntax hilighting
      syntax enable

      " replace tabs
      set tabstop=2
      set shiftwidth=2
      set expandtab
    '';
  };

  #pkgs.vim.ftNix = false;
  #vim = {ftNix = false;};
}