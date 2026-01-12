vim.pack.add({
  {
    src = "https://github.com/folke/trouble.nvim.git",
    name = "trouble.nvim",
    version = "v3.7.1",
  },
  {
    src = "https://github.com/folke/todo-comments.nvim.git",
    name = "todo-comments.nvim",
    version = "v1.5.0",
  },
})

vim.defer_fn(function()
  local todo_comments_ok, todo_comments = pcall(require, "todo-comments")
  if not todo_comments_ok then
    vim.notify("todo-comments.nvim not found", vim.log.levels.ERROR)
    return
  end
  todo_comments.setup({})

  vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Telescope)" })

  print("todo-comments.nvim loaded")
end, 30)
