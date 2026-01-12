vim.pack.add({
  {
    src = "https://github.com/hrsh7th/nvim-cmp.git",
    name = "nvim-cmp",
    version = "v0.0.2",
  },
  {
    src = "https://github.com/hrsh7th/cmp-nvim-lsp.git",
    name = "cmp-nvim-lsp",
  },
  {
    src = "https://github.com/hrsh7th/cmp-buffer.git",
    name = "cmp-buffer",
  },
  {
    src = "https://github.com/hrsh7th/cmp-path.git",
    name = "cmp-path",
  },
  {
    src = "https://github.com/hrsh7th/cmp-cmdline.git",
    name = "cmp-cmdline",
  },
  {
    src = "https://github.com/L3MON4D3/LuaSnip.git",
    name = "LuaSnip",
    version = "v2.4.1",
  },
  {
    src = "https://github.com/saadparwaiz1/cmp_luasnip.git",
    name = "cmp_luasnip",
  },
})

vim.defer_fn(function()
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<Esc>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "buffer" },
    }),
  })

  -- Use buffer source for `/` and `?`
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end, 0)
