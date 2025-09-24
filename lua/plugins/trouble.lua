vim.pack.add({
  {
    src = "https://github.com/folke/trouble.nvim.git",
    name = "trouble.nvim",
  },
})

vim.defer_fn(function()
  local trouble_ok, trouble = pcall(require, "trouble")
  if not trouble_ok then
    vim.notify("trouble.nvim not found", vim.log.levels.ERROR)
    return
  end
  trouble.setup({})

  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
  vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })

  print("trouble.nvim loaded")
end, 50)
