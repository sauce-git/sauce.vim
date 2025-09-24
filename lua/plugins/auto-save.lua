vim.pack.add({
  {
    src = "https://github.com/Pocco81/auto-save.nvim.git",
    name = "auto-save.nvim",
  },
})

vim.defer_fn(function()
  local ok, autosave = pcall(require, "auto-save")
  if not ok then
    vim.notify("auto-save.nvim not found", vim.log.levels.ERROR)
    return
  end

  autosave.setup({
    debounce_delay = 500,
    execution_message = {
      message = function()
        return ""
      end,
    },
  })

  vim.keymap.set("n", "<leader>uv", "<cmd>ASToggle<CR>", { desc = "Toggle autosave" })
end, 0)
