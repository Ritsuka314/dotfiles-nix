{ pkgs, ... }:

let
  vim-easymotion-vscode = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-easymotion-vscode";
    version = "2020-06-13";
    src = pkgs.fetchFromGitHub {
      owner = "asvetliakov";
      repo = "vim-easymotion";
      rev = "34fb922c3cf5e88cff3f0824005e219dce83ea6f";
      sha256 = "rcpks3GDu+HVb57gStcAPo+qOQf11b9uMghGsAjh1G8=";
    };
  };
  nvim-scrollbar = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-scrollbar";
    version = "2020-01-11";
    src = pkgs.fetchFromGitHub {
      owner = "petertriho";
      repo = "nvim-scrollbar";
      rev = "3ef33825db78e663ef6284f4056ce7aaa6cfe1c9";
      sha256 = "1RADFi4CRadFn9Q+E9pOhiPnZGDKs4WQycbXZB47I4I=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # navigation
      { plugin   = vim-easymotion;
        optional = true;
      }
      { plugin   = vim-easymotion-vscode;
        optional = true;
      }
      quick-scope
      # edit
      { plugin   = vim-commentary;
        optional = true;
      }
      # apparance
      neoscroll-nvim
      nvim-scrollbar
      nvim-cursorline
      # language
      nvim-lspconfig
      vim-nix
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
      ]))
    ]; 
    extraConfig = builtins.readFile ./init.vim;
  };

}
