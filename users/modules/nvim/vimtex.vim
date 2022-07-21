if !exists('g:vscode')
  packadd vimtex
  " let g:vimtex_view_general_viewer = '/mnt/c/Users/richard/AppData/Local/Okular/bin/okular.exe'
  " let g:vimtex_view_general_options = '--unique file:"$(wslpath -w @pdf)"#src:@line@tex'
  
  " put this in sumatra inverse search command
  " bash -c '/home/richard/.nix-profile/bin/nvim --headless -c "VimtexInverseSearch %l \"$(wslpath -u "%f")\""'
  let g:vimtex_view_method = 'sumatra'
  let g:sumatra = '/mnt/c/Program Files/SumatraPDF/SumatraPDF.exe'
  let g:synctex = '/mnt/d/program files/texlive/2022/bin/win32/synctex.exe' 

  set packpath^=~/.vim
  set runtimepath^=~/.vim

  let g:vimtex_compiler_latexmk = { 'executable' : 'latexmk.exe' }
endif