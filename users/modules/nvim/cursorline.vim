if exists('g:vscode')
  " doesn't work with vsc
else
  packadd nvim-cursorline
lua << EOF
  require('nvim-cursorline').setup ({
    cursorline = {
      enable = true,
      timeout = 1000,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true, cterm = { underline = true } },
    }
  })
EOF
endif
