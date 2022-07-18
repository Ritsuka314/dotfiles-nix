{ pkgs, ... }:

let
  configPlugin = plugin : cfg :
    { plugin = plugin; } // cfg;
  #### navigation
  nvim-treesitter-pairs = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-treesitter-pairs";
    version = "2022-04-16";
    src = pkgs.fetchFromGitHub {
      owner = "theHamsta";
      repo = "nvim-treesitter-pairs";
      rev = "68a8d3d0bebc9173e862b9f8c5957b7f82cd0d60";
      sha256 = "1MRLZ3mc/QI2bjZg43cF43LGzzwtD0grS1w5YgdDMBU=";
    };
  };
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
  nvim-tree-climber = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "tree-climber.nvim";
    version = "2022-07-02";
    src = pkgs.fetchFromGitHub {
      owner = "drybalka";
      repo = "tree-climber.nvim";
      rev = "06588baea4e8faca29645aeca7de4a76f8b83eba";
      sha256 = "qBdbdL/DfizSpFB2sMy9d+U/rJSi5evOEcRHciQWNjI=";
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
  nvim-ts-hint-textobject = pkgs.vimUtils.buildVimPluginFrom2Nix { # aka. nvim-treehopper
    pname = "nvim-ts-hint-textobject";
    version = "2021-12-20";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-treehopper";
      rev = "59a589471c85ebf9479089c4ca1638021b9a10e3";
      sha256 = "/HNvhwuiRN4Vbj9Q26oFUjboXMH/2wFk4NPexUf81Ho=";
    };
  };
  #### appearance
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
  #### others
  win32yank = pkgs.stdenv.mkDerivation {
    pname = "win32yank";
    version = "0.0.4";
    # https://github.com/equalsraf/win32yank
    src = ./nvim;
    installPhase = ''
      mkdir -p $out
      cp $src/win32yank.exe $out/
      chmod +x $out/win32yank.exe
    '';
    preferLocalBuild = true;
};
in
{ 
  home.packages = [
    win32yank
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      (configPlugin impatient-nvim {
        config   = "lua require('impatient')";
      })
      #### navigation
      nvim-treesitter-pairs
      # (configPlugin vim-easymotion-vscode { optional = true; })
      # (configPlugin vim-easymotion        { optional = true; 
      #   config   = ''
      #     if exists('g:vscode')
      #       packadd vim-easymotion-vscode
      #     else
      #       packadd vim-easymotion
      #     endif
      #     '';
      # })
      (configPlugin leap {
        optional = true;  # have to manually load so can set key map after loading
        type     = "lua";
        config   = ''
          require('leap').set_default_keymaps()
          -- Bidirectional search in the current window is just a specific case of the
          -- multi-window mode.
          leap_bidi = function()
            local current_window = vim.api.nvim_get_current_win()
            require'leap'.leap { target_windows = { current_window } }
          end
          lhss = { '<Plug>(leap-forward)', '<Plug>(leap-backward)' }
          for _, lhs in pairs(lhss) do
            vim.keymap.set({'n', 'x', 'o'}, lhs, leap_bidi)
          end
        '';
      })
      # (configPlugin nvim-tree-climber { # depends on treesitter
      #   type     = "lua";
      #   config   = builtins.readFile ./nvim/tree-climber.lua;
      # })
      # (configPlugin syntax-tree-surfer { # depends on treesitter
      #   type     = "lua";
      #   config   = builtins.readFile ./nvim/syntax-tree-surfer.lua;
      # })
      # (configPlugin nvim-ts-hint-textobject { # depends on treesitter
      #   config   = ''
      #     omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
      #     vnoremap <silent> m :lua require('tsht').nodes()<CR>
      #   '';
      # })
      #### appearance
      (configPlugin dracula-vim {
        optional = true;
        config   = "if !exists('g:vscode') | packadd dracula-vim | colorscheme dracula | endif";
      })
      nvim-ts-rainbow # depends on treesitter
      (configPlugin twilight-nvim { # depends on treesitter
        optional = true; # manually load plugin so can do TwilightEnable 
        config   = ''
          packadd twilight.nvim
          lua require('twilight').setup()
          highlight Twilight ctermfg='8' ctermbg='236'
          TwilightEnable
        '';
      })
      (configPlugin lualine-nvim {
        optional = true;
        config   = ''
          if !exists('g:vscode')
            packadd lualine.nvim
            lua require('lualine').setup()
          endif'';
      })
      nvim-treesitter-context # depends on treesitter
      (configPlugin indent-blankline-nvim {
        type     = "lua";
        config   = builtins.readFile ./nvim/indent-blankline.lua;
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
      #### edit
      (configPlugin vim-commentary {
        optional = true;
        config   = builtins.readFile ./nvim/commentary.vim;
      })
      nvim-treesitter-refactor
      #### util
      (configPlugin which-key-nvim {
        optional = true;
        config   = ''
          if !exists('g:vscode')
            packadd which-key.nvim
            lua require("which-key").setup()
          endif'';
      })
      #### language
      nvim-lspconfig
      vim-nix
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
          tree-sitter-latex
          tree-sitter-lua
      ]))
    ]; 
    extraConfig = ''
      let g:win32yank='${win32yank}/win32yank.exe'
      source ${./nvim/treesitter.lua}
      source ${./nvim/init.lua}'';
  };

}
