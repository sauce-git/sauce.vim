vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    name = "nvim-treesitter",
    version = "v0.9.3",
  },
})

vim.defer_fn(function()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if not ok then
    vim.notify("nvim-treesitter not found", vim.log.levels.ERROR)
    return
  end

  -- Install parsers
  local languages = {
    "c",
    "cpp",
    "go",
    "lua",
    "python",
    "rust",
    "typescript",
    "javascript",
    "html",
    "css",
    "json",
    "yaml",
    "toml",
    "markdown",
    "bash",
  }

  treesitter.install(languages)

  -- Enable highlighting for all filetypes
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if not vim.b[buf].treesitter_enabled then
        pcall(vim.treesitter.start)
        vim.b[buf].treesitter_enabled = true
      end
    end,
  })

  vim.notify("nvim-treesitter loaded", vim.log.levels.INFO)
end, 0)
