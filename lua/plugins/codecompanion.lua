return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat<cr>", desc = "Code Companion Chat" },
      { "<leader>ap", "<cmd>CodeCompanion<cr>", desc = "Code Companion Prompt" },
      { "<leader>ac", "<cmd>CodeCompanionAction<cr>", desc = "Code Companion Action" },
    },
    opts = {
      strategies = {
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
