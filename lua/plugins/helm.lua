vim.pack.add({
  {
    src = "https://github.com/towolf/vim-helm.git",
    name = "vim-helm",
  },
})

-- Load vim-helm after treesitter to prevent conflicts
vim.defer_fn(function()
  -- Set up Helm file detection and settings
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.yaml", "*.yml"},
    callback = function()
      local path = vim.fn.expand("%:p")
      local filename = vim.fn.expand("%:t")

      -- Check if it's a Helm file by path or content
      if string.match(path, "templates/") or
         string.match(path, "charts/") or
         string.match(path, "helm") or
         string.match(filename, "values") or
         string.match(filename, "Chart") then

        vim.opt_local.backup = false
        vim.opt_local.writebackup = false
        vim.opt_local.swapfile = false
        vim.bo.filetype = "helm"
      end
    end,
  })

  -- Explicit Helm filetype settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "helm",
    callback = function()
      vim.opt_local.backup = false
      vim.opt_local.writebackup = false
      vim.opt_local.swapfile = false
    end,
  })
end, 100) -- Load with delay after treesitter