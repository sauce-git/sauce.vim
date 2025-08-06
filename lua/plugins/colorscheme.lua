return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = false,
      styles = {
        -- sidebars = "transparent",
        -- floats = "transparent",
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      typeStyle = {},
      statementStyle = { bold = true },
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = false, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          dragon = {},
          lotus = {},
          all = {
            ui = {
              -- bg_gutter = "none",
              -- nontext = "#6F6F6F",
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          -- return {
          --   NormalFloat = { bg = "none" },
          --   FloatTitle = { bg = "none" },
          --   FloatBorder = { bg = "none" },
          --
          --   -- Save an hlgroup with dark background and dimmed foreground
          --   -- so that you can use it where your still want darker windows.
          --   -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          --   NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          --
          --   -- Popular plugins that open floats will link to NormalFloat by default;
          --   -- set their background accordingly if you wish to keep them dark and borderless
          --   LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          --   MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          --   NeoTreeWinSeparator = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          -- }
        end,
      },
      theme = "wave", -- Load "wave" theme
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zaibatsu", -- set the colorscheme
    },
  },
}
