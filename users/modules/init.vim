" enable syntax hilighting
syntax enable

" replace tabs
set tabstop=2
set shiftwidth=2
set expandtab

if exists('g:vscode')
  " set `vscode-neovim.textDecorationsAtTop` to true
  packadd vim-easymotion-vscode
else
  packadd vim-easymotion
endif
" move to {char}
map <Plug>(easymotion-prefix)f   <Plug>(easymotion-bd-f)
" move to line
map <Plug>(easymotion-prefix)k   <Plug>(easymotion-bd-jk)
map <Plug>(easymotion-prefix)j   <Plug>(easymotion-bd-jk)
" move within line
map <Plug>(easymotion-prefix)h   <Plug>(easymotion-lineanywhere)
map <Plug>(easymotion-prefix)l   <Plug>(easymotion-lineanywhere)
" move to word
map <Plug>(easymotion-prefix)w   <Plug>(easymotion-bd-w)
map <Plug>(easymotion-prefix)W   <Plug>(easymotion-bd-W)
map <Plug>(easymotion-prefix)e   <Plug>(easymotion-bd-e)
map <Plug>(easymotion-prefix)E   <Plug>(easymotion-bd-E)
" search (doesn't work with vsc)
" map  <Plug>(easymotion-prefix)/ <Plug>(easymotion-sn)
" omap <Plug>(easymotion-prefix)/ <Plug>(easymotion-tn)

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