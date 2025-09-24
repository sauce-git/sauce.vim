vim.pack.add({
  {
    src = "https://github.com/nvim-lua/plenary.nvim.git",
    name = "plenary.nvim",
  },
  {
    src = "https://github.com/kdheepak/lazygit.nvim.git",
    name = "lazygit.nvim",
  },
})

vim.defer_fn(function()
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_floating_window_scaling_factor = 0.7
  vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
  vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
end, 0)
