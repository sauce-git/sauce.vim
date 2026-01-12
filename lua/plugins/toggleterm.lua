vim.pack.add({
  {
    src = "https://github.com/akinsho/toggleterm.nvim.git",
    name = "toggleterm.nvim",
    version = "v2.13.1",
  },
})

vim.defer_fn(function()
  local ok, toggleterm = pcall(require, "toggleterm")
  if not ok then
    vim.notify("toggleterm.nvim not found", vim.log.levels.ERROR)
    return
  end

  toggleterm.setup({})

  vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "toggle terminal" })
end, 0)
