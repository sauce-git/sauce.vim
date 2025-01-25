return {
	"kmontocam/nvim-conda",
	dependencies = { "nvim-lua/plenary.nvim" },
	Config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>coa", "<cmd>CondaActivate<CR>", {
			desc = "CondaActivate",
		}) -- :CondaActivate
		keymap.set("n", "<leader>cod", "<cmd>CondaDeactivate<CR>", {
			desc = "CondaDeactivate",
		}) -- :CondaDeactivate
	end,
}
