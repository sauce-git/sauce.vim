vim.pack.add({
  {
    src = "https://github.com/github/copilot.vim.git",
    name = "copilot",
    version = "v1.59.0",
  },
})

vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

vim.keymap.set("n", "<leader>cd", function()
  if vim.g.copilot_enabled == true then
    vim.g.copilot_enabled = false
    print("Copilot disabled")
  else
    vim.g.copilot_enabled = true
    print("Copilot enabled")
  end
end)

vim.g.copilot_no_tab_map = true
