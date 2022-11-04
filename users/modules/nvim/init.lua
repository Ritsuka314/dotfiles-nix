local v = vim
local c = v.cmd
local g = v.g
local o = v.opt

-- auto toggle line number mode
if not g.vscode then
  -- enable syntax hilighting
  o.syntax = "on"

  o.number = true

  c [[
    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END
  ]]
else
  o.syntax = "off"
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
          
o.clipboard:append { "unnamedplus" }
g.clipboard = {
  name = 'win32yank-wsl',
  copy = {
      ['+'] = g.win32yank .. " -i --crlf",
      ['*'] = g.win32yank .. " -i --crlf",
    },
  paste = {
      ['+'] = g.win32yank .. " -o --lf",
      ['*'] = g.win32yank .. " -o --lf",
  },
  cache_enabled = 0,
}