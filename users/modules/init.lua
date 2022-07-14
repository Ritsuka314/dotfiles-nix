local v = vim
local c = v.cmd
local g = v.g
local o = v.opt

-- enable syntax hilighting
o.syntax = "on"

-- auto toggle line number mode
if not g.vscode then
  o.number = true

  c [[
    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END
  ]]
end

-- replace tabs
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- Use mouse
o.mouse = "a" -- all modes (n)ormal (v)isual (i)insert (c)ommand-line

-- Miscellaneous quality of life
o.ignorecase = true
o.completeopt = "menuone,noselect"