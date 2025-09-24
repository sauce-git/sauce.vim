vim.pack.add({
  {
    src = "https://github.com/github/copilot.vim.git",
    name = "copilot",
  },
})

vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})

vim.g.copilot_no_tab_map = true
