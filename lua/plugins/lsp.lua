vim.pack.add({
  -- LSP Config
  {
    src = "https://github.com/neovim/nvim-lspconfig.git",
    name = "nvim-lspconfig",
    version = "v2.5.0",
  },
  -- Mason (LSP Installer)
  {
    src = "https://github.com/mason-org/mason.nvim.git",
    name = "mason.nvim",
    version = "v2.2.1",
  },
  {
    src = "https://github.com/mason-org/mason-lspconfig.nvim.git",
    name = "mason-lspconfig.nvim",
    version = "v2.1.0",
  },
  -- Conform (Formatter)
  {
    src = "https://github.com/stevearc/conform.nvim.git",
    name = "conform.nvim",
    version = "v9.1.0",
  },
})

vim.defer_fn(function()
  -- Mason Setup
  local mason_ok, mason = pcall(require, "mason")
  local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not (mason_ok and mason_lspconfig_ok) then
    vim.notify("LSP Config dependencies not found", vim.log.levels.ERROR)
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
      "cssls",
      "helm_ls",
      "eslint",
    },
  })

  -- LSP Setup (Neovim 0.11+ vim.lsp.config)
  vim.lsp.config("ts_ls", {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  })

  vim.lsp.config("eslint", {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  })

  vim.lsp.enable("ts_ls", "eslint")

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
