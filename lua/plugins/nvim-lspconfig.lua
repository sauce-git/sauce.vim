return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>rs", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
      keys[#keys + 1] = { "<C-k>", false, mode = { "i" }, desc = "Signature Help" }
    end,
  },
}
