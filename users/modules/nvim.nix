{ pkgs, ... }:

let
  vim-easymotion-vscode = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-easymotion-vscode";
    version = "2020-01-11";
    src = pkgs.fetchFromGitHub {
      owner = "asvetliakov";
      repo = "vim-easymotion";
      rev = "34fb922c3cf5e88cff3f0824005e219dce83ea6f";
      sha256 = "rcpks3GDu+HVb57gStcAPo+qOQf11b9uMghGsAjh1G8=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      { plugin   = vim-easymotion;
        optional = true;
      }
      { plugin   = vim-easymotion-vscode;
        optional = true;
      }
      { plugin   = vim-commentary;
        optional = true;
      }
      quick-scope
      nvim-lspconfig
      vim-nix
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
      ]))
    ]; 
    extraConfig = ''
      " enable syntax hilighting
      syntax enable

      " replace tabs
      set tabstop=2
      set shiftwidth=2
      set expandtab

      if exists('g:vscode')
        packadd vim-easymotion-vscode
      else
        packadd vim-easymotion
      endif

      if exists('g:vscode')
        " VSCode extension
        xmap gc  <Plug>VSCodeCommentary
        nmap gc  <Plug>VSCodeCommentary
        omap gc  <Plug>VSCodeCommentary
        nmap gcc <Plug>VSCodeCommentaryLine
      else
        " ordinary neovim
        packadd vim-commentary
      endif

      highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
      highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    '';
  };

}
