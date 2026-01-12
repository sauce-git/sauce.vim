vim.pack.add({
  {
    src = "https://github.com/stevearc/dressing.nvim.git",
    name = "dressing.nvim",
    version = "v3.1.1",
  },
  {
    src = "https://github.com/nvim-lua/plenary.nvim.git",
    name = "plenary.nvim",
    version = "v0.1.4",
  },
  {
    src = "https://github.com/nvim-flutter/flutter-tools.nvim.git",
    name = "flutter-tools.nvim",
    version = "v2.1.0",
  },
})

vim.defer_fn(function()
  local ok, flutter_tools = pcall(require, "flutter-tools")
  if not ok then
    vim.notify("flutter-tools.nvim not found", vim.log.levels.ERROR)
    return
  end

  flutter_tools.setup({})
  print("flutter-tools.nvim loaded")
end, 100)
