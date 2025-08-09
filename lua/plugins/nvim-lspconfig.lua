return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>rs", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
      keys[#keys + 1] = { "<C-k>", false, mode = { "i" }, desc = "Signature Help" }
      keys[#keys + 1] = {
        "<leader>rn",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename.nvim)",
        has = "rename",
      }
    end,
  },
}
