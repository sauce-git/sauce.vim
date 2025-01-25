return {
	"zootedb0t/citruszest.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("citruszest").setup({
			option = {
				transparent = true,
			},
			style = {
				Comment = { italic = true },
				SpecialComment = { italic = true },
				Keyword = { italic = true },
				Statement = { bold = true },
				-- LineNr = { bg = "#1e1e1e" },
				-- CursorLineNr = { bg = "#1e1e1e" },
        EndOfBuffer = { fg = "#1e1e1e" },
			},
		})

		-- Set the colorscheme
		-- vim.cmd("colorscheme citruszest")
	end,
}
