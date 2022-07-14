{ pkgs, ... }:

let
  configPlugin = plugin : cfg :
    { plugin = plugin; } // cfg;
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
  syntax-tree-surfer = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "syntax-tree-surfer";
    version = "2022-07-03";
    src = pkgs.fetchFromGitHub {
      owner = "ziontee113";
      repo = "syntax-tree-surfer";
      rev = "9d5879ab6f2f4f02ce5bd0777e67b11de2c41b22";
      sha256 = "FDuwni5DQy4pdiEKPGb/GqWu6RFB2c25rQwx9HpKFPk=";
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
  leap = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "leap.nvim";
    version = "2022-07-08";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "1bb1fec369b1e9ae96e6ff1b829ea9272c51f844";
      sha256 = "dH0v1D5q5OlMLA/omTDMb/taKyIgQ5VfVMYXJ609k/k=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      (configPlugin impatient-nvim {
        config = "lua require('impatient')";
      })
      # navigation
      (configPlugin leap {
        config   = "lua require('leap').set_default_keymaps()";
      })
      (configPlugin syntax-tree-surfer {
        type     = "lua";
        config   = builtins.readFile ./nvim/syntax-tree-surfer.lua;
      })
      # edit
      (configPlugin vim-commentary {
        optional = true;
        config   = builtins.readFile ./nvim/commentary.vim;
      })
      # apparance
      (configPlugin dracula-vim {
        optional = true;
        config   = "if !exists('g:vscode') | packadd dracula-vim | colorscheme dracula | endif";
      })
      (configPlugin lualine-nvim {
        optional = true;
        config   = ''
          if !exists('g:vscode')
            packadd lualine.nvim
            lua require('lualine').setup()
          endif'';
      })
      (configPlugin indent-blankline-nvim {
        optional = true;
        config = ''
          if !exists('g:vscode')
            packadd indent-blankline.nvim
          lua << EOF
              require('indent_blankline').setup({
                show_current_context = true,
                show_current_context_start = true
              })
          EOF
          endif'';
      })
      (configPlugin neoscroll-nvim {
        optional = true;
        config   = "if !exists('g:vscode') | packadd neoscroll.nvim | endif";
      })
      (configPlugin nvim-scrollbar {
        optional = true;
        config   = "if !exists('g:vscode') | packadd nvim-scrollbar | endif";
      })
      (configPlugin nvim-cursorline {
        optional = true;
        config   = builtins.readFile ./nvim/cursorline.vim;
      })
      # util
      (configPlugin which-key-nvim {
        optional = true;
        config   = ''
          if !exists('g:vscode')
            packadd which-key.nvim
            lua require("which-key").setup()
          endif'';
      })
      # language
      nvim-lspconfig
      vim-nix
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
          tree-sitter-latex
      ]))
    ]; 
    extraConfig = "source ${./init.lua}";
  };

}
