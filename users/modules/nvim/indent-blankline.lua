if not vim.g.vscode then
  vim.cmd [[ packadd indent-blankline.nvim ]]
  require('indent_blankline').setup({
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true
  })
end