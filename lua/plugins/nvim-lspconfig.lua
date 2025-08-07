return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>rs", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
    end,
  },
}
