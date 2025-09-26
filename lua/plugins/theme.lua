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
      -- Completion menu (nvim-cmp)
      "Pmenu",
      "PmenuSbar",
      "PmenuThumb",
      -- Floating windows
      "FloatBorder",
      "NormalFloat",
      -- FZF-lua
      "FzfLuaNormal",
      "FzfLuaBorder",
      "FzfLuaTitle",
      "FzfLuaPreviewNormal",
      "FzfLuaPreviewBorder",
      -- LSP
      "LspInfoBorder",
      "LspSignatureActiveParameter",
      -- Diagnostics
      "DiagnosticFloatingError",
      "DiagnosticFloatingWarn",
      "DiagnosticFloatingInfo",
      "DiagnosticFloatingHint",
      -- TreeSitter
      "TreesitterContext",
      -- Sidebar and splits
      "VertSplit",
      "WinSeparator",
      -- Status line (lualine)
      "StatusLine",
      "StatusLineNC",
      -- Terminal
      "TermCursor",
      "TermCursorNC",
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
    src = "https://github.com/scottmckendry/cyberdream.nvim.git",
    name = "cyberdream.nvim",
  },
  {
    src = "https://github.com/zaldih/themery.nvim.git",
    name = "themery.nvim",
  },
})

vim.defer_fn(function()
  local cyberdream_ok, cyberdream = pcall(require, "cyberdream")
  if not cyberdream_ok then
    vim.notify("cyberdream.nvim not found", vim.log.levels.ERROR)
    return
  end
  cyberdream.setup({
    styles = {
      comments = { italic = true },
      functions = { bold = true },
      keywords = { italic = true, bold = true },
      strings = {},
      variables = { bold = true },
    },
    transparent_bg = true,
    lualine_bold = true,
  })

  local themery_ok, themery = pcall(require, "themery")
  if not themery_ok then
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
      "retrobox",
      "ron",
      "shine",
      "slate",
      "sorbet",
      "torte",
      "unokai",
      "vim",
      "wildcharm",
      "zaibatsu",
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
      {
        name = "cyberdream",
        colorscheme = "cyberdream",
      },
    },
    livePreview = true, -- live preview when cycling through themes
  })

  vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", { desc = "open themery" })

  print("themery.nvim loaded")
end, 0)
