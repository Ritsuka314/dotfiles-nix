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