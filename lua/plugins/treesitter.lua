vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    name = "nvim-treesitter",
    version = "v0.10.0",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-context.git",
    name = "nvim-treesitter-context",
    version = "v1.0.0",
  },
})

local treesitter = require("nvim-treesitter")

treesitter
  .install({
    "c",
    "cpp",
    "lua",
    "python",
    "javascript",
    "typescript",
    "tsx",
    "jsx",
    "html",
    "css",
    "json",
    "bash",
    "go",
    "rust",
  })
  :wait(3000000)

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
