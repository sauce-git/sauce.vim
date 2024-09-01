return {
	"pocco81/auto-save.nvim",
	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>tas", "<cmd>ASToggle<CR>", { desc = "Toggle auto save mod" }) -- Toggle auto save mod
	end,
}
