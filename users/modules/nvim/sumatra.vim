function! vimtex#view#sumatra#new() abort
  " Add reverse search mapping
  return s:viewer.init()
endfunction

let s:viewer = vimtex#view#_template#new({
      \ 'name': 'Sumatra',
      \})

function! s:viewer._check() dict abort " {{{1
  " Check if Sumatra is executable
  if !executable(g:sumatra)
    call vimtex#log#error('Sumatra is not executable!')
    return v:false
  endif

  return v:true
endfunction

function! s:viewer._start(outfile) dict abort " {{{1
  let l:path = vimtex#jobs#capture('wslpath -w ' . vimtex#util#shellescape(a:outfile))[0]
  let l:cmd = '"' . g:sumatra . '"'
  let l:cmd .= ' ' . '-reuse-instance'
  let l:cmd .= ' ' . '"' . l:path . '"'
  let l:cmd .= '&'
  let self.cmd_start = l:cmd

  call vimtex#jobs#run(self.cmd_start)

  call self._forward_search(a:outfile)
endfunction

function! s:viewer._forward_search(outfile) dict abort " {{{1
  if !executable(g:synctex) | return | endif

  let l:input = vimtex#jobs#capture('wslpath -w ' . vimtex#util#shellescape(expand('%:p')))[0]
  let l:output = vimtex#jobs#capture('wslpath -w ' . vimtex#util#shellescape(a:outfile))[0]
  
  let self.cmd_synctex_view = '"' . g:sumatra . '"'
    \. ' -reuse-instance'
    \. ' -forward-search '
    \. '"' . l:input . '" '
    \. line('.')
    \. ' "' . l:output . '"'
    \. ' &'

  call vimtex#jobs#run(self.cmd_synctex_view)
endfunction
