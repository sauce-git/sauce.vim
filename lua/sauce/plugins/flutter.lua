return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({})

			local keymap = vim.keymap -- for conciseness

			-- Flutter keymaps
			keymap.set("n", "<leader>flr", ":FlutterRun --flavor development lib/main_development.dart<CR>", { desc = "Run flutter" }) -- run
			keymap.set("n", "<leader>fls", ":FlutterQuit<CR>", { desc = "Stop flutter" }) -- stop
			keymap.set("n", "<leader>fle", ":FlutterEmulators<CR>", { desc = "Emulators" }) -- emulator
			keymap.set("n", "<leader>fld", ":FlutterDevices<CR>", { desc = "Devices" }) -- devices
			keymap.set("n", "<leader>fltl", ":FlutterLogToggle<CR>", { desc = "Toggle log" }) -- toggle log
		end,
	},
}
