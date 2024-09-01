return {
	-- :Copilot setup to enalbe copilot.vim
	"github/copilot.vim",
	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>cpi", "<cmd>Copilot setup<CR>", {
			desc = "Copilot setup",
		}) -- :Copilot setup
		keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<CR>", {
			desc = "Copilot enable",
		}) -- :Copilot enable
		keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<CR>", {
			desc = "Copilot disable",
		}) -- :Copilot disable
		keymap.set("n", "<leader>cps", "<cmd>Copilot status<CR>", {
			desc = "Copilot status",
		}) -- :Copilot status
	end,
}
