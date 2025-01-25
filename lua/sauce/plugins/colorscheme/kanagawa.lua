return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("kanagawa").setup({
				theme = "dragon",
				compile = false,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = false, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						lotus = {},
						dragon = {},
						all = {
							ui = {
                bg_gutter = "none",
                nontext = "#6F6F8F",
							},
						},
					},
				},
				background = {
					dark = "wave",
					light = "lotus",
				},
				undercurl = true,
				overrides = function(colors)
					local theme = colors.theme

					return {
						-- for transparency
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					}
				end,
			})

			-- Set the colorscheme
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
