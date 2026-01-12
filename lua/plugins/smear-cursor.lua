vim.pack.add({
  {
    src = "https://github.com/sphamba/smear-cursor.nvim",
    name = "smear-cursor.nvim",
    version = "v0.6.0",
  },
})

vim.defer_fn(function()
  local ok, smear = pcall(require, "smear_cursor")
  if not ok then
    vim.notify("smear-cursor.nvim not found", vim.log.levels.ERROR)
    return
  end

  smear.setup({
    stifness = 0.8,
    trailing_stiffness = 0.5,
    distance_stop_animating = 0.5,
  })
end, 0)
