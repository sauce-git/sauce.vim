vim.pack.add({
  {
    src = "https://github.com/nvim-tree/nvim-web-devicons.git",
    name = "nvim-web-devicons",
  },
  {
    src = "https://github.com/ibhagwan/fzf-lua.git",
    name = "fzf-lua",
  },
})

vim.defer_fn(function()
  local ok, fzf = pcall(require, "fzf-lua")
  if not ok then
    vim.notify("fzf-lua not found", vim.log.levels.ERROR)
    return
  end

  fzf.setup({
    winopts = {
      height = 0.85,
      width = 0.80,
      on_create = function()
        vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
        vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
      end,
    },
  })

  -- Set fzf-lua as the UI selector for code actions
  fzf.register_ui_select()

  vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files" })
  vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Live Grep" })

  print("fzf-lua loaded")
end, 100)
