vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    name = "nvim-treesitter",
  },
})

vim.defer_fn(function()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if not ok then
    vim.notify("nvim-treesitter not found", vim.log.levels.ERROR)
  end

  treesitter.setup({
    ensure_installed = {
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
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })
  vim.notify("nvim-treesitter loaded", vim.log.levels.INFO)
end, 0)
