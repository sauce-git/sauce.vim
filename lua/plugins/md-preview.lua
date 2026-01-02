vim.pack.add({
  {
    src = "https://github.com/iamcco/markdown-preview.nvim",
    name = "markdown-preview.nvim",
  },
})

vim.defer_fn(function()
  vim.fn["mkdp#util#install"]()

  vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
end, 50)
