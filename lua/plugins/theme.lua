local hostname = vim.fn.hostname()

if hostname == "sauce-arch" then
  vim.pack.add({
    {
      src = "https://github.com/tribela/transparent.nvim.git",
      name = "transparent.nvim",
    },
  })

  local ok, transparent = pcall(require, "transparent")
  if not ok then
    vim.notify("transparent.nvim not found", vim.log.levels.ERROR)
    return
  end

  transparent.setup({
    auto = true,
    extra_groups = {
      "Pmenu",
      "PmenuSbar",
      "FloatBorder",
    },
  })

  vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "toggle transparency" })
end

vim.pack.add({
  {
    src = "https://github.com/rebelot/kanagawa.nvim.git",
    name = "kanagawa.nvim",
  },
  {
    src = "https://github.com/zaldih/themery.nvim.git",
    name = "themery.nvim",
  },
})

vim.defer_fn(function()
  local ok, themery = pcall(require, "themery")
  if not ok then
    vim.notify("themery.nvim not found", vim.log.levels.ERROR)
    return
  end

  themery.setup({
    themes = {
      "default",
      "blue",
      "darkblue",
      "delek",
      "desert",
      "elflord",
      "evening",
      "habamax",
      "industry",
      "koehler",
      "lunaperche",
      "morning",
      "murphy",
      "pablo",
      "peachpuff",
      "quiet",
      "ron",
      "shine",
      "slate",
      "torte",
      "zellner",
      {
        name = "kanagawa-lotus",
        colorscheme = "kanagawa-lotus",
      },
      {
        name = "kanagawa-wave",
        colorscheme = "kanagawa-wave",
      },
      {
        name = "kanagawa-dragon",
        colorscheme = "kanagawa-dragon",
      },
    },
    livePreview = true, -- live preview when cycling through themes
  })

  vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", { desc = "open themery" })

  print("themery.nvim loaded")
end, 50)
