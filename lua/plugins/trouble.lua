vim.pack.add({
  {
    src = "https://github.com/folke/todo-comments.nvim.git",
    name = "todo-comments.nvim",
  },
  {
    src = "https://github.com/folke/trouble.nvim.git",
    name = "trouble.nvim",
  },
})

vim.defer_fn(function()
  -- Trouble.nvim
  local trouble_ok, trouble = pcall(require, "trouble")
  if not trouble_ok then
    vim.notify("trouble.nvim not found", vim.log.levels.ERROR)
    return
  end
  trouble.setup({})

  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
  vim.keymap.set(
    "n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Buffer Diagnostics (Trouble)" }
  )
  vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
  vim.keymap.set(
    "n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references / ... (Trouble)" }
  )
  vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
  vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

  print("trouble.nvim loaded")

  -- todo-comments.nvim
  local todo_comments_ok, todo_comments = pcall(require, "todo-comments")
  if not todo_comments_ok then
    vim.notify("todo-comments.nvim not found", vim.log.levels.ERROR)
    return
  end
  todo_comments.setup({})

  vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Telescope)" })

  print("todo-comments.nvim loaded")
end, 50)
