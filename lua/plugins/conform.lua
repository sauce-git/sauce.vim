vim.pack.add({
  {
    src = "https://github.com/mason-org/mason.nvim.git",
    name = "mason.nvim",
  },
  {
    src = "https://github.com/stevearc/conform.nvim.git",
    name = "conform.nvim",
  },
})

vim.defer_fn(function()
  local mason_ok, mason = pcall(require, "mason")
  if not mason_ok then
    vim.notify("mason.nvim not found", vim.log.levels.ERROR)
    return
  end

  local conform_ok, conform = pcall(require, "conform")
  if not conform_ok then
    vim.notify("conform.nvim not found", vim.log.levels.ERROR)
    return
  end

  mason.setup()
  conform.setup({
    default_format_opts = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
      lsp_format = "fallback", -- not recommended to change
    },
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      go = { "golangci-lint" },
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
    },
  })
end, 100)
