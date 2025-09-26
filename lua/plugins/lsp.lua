vim.pack.add({
  -- LSP Config
  {
    src = "https://github.com/neovim/nvim-lspconfig.git",
    name = "nvim-lspconfig",
  },
  -- Mason (LSP Installer)
  {
    src = "https://github.com/mason-org/mason.nvim.git",
    name = "mason.nvim",
  },
  {
    src = "https://github.com/mason-org/mason-lspconfig.nvim.git",
    name = "mason-lspconfig.nvim",
  },
  -- Conform (Formatter)
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

  local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mason_lspconfig_ok then
    vim.notify("mason-lspconfig.nvim not found", vim.log.levels.ERROR)
    return
  end

  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "pyright",
      "ts_ls",
      "gopls",
      "rust_analyzer",
      "clangd",
      "yamlls",
      "jsonls",
      "html",
    },
  })

  local conform_ok, conform = pcall(require, "conform")
  if not conform_ok then
    vim.notify("conform.nvim not found", vim.log.levels.ERROR)
    return
  end

  conform.setup({
    default_format_opts = {
      timeout_ms = 1000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
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

  -- Keymaps
  local map = vim.keymap.set
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
  map("n", "<leader><leader>", function()
    require("conform").format({ async = true })
    print("Formatting...")
  end, { desc = "Format" })
end, 0)
