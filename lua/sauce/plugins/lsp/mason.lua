return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-java/nvim-java",
	},
	config = function()
		-- import dependencies
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local java = require("java")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- enable nvim-java
		java.setup({
			jdk = {
				auto_install = false,
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"eslint",
				"prismals",
				"pyright",
				"rust_analyzer",
				"buf_ls",
				"dockerls",
				"bashls",
				"clangd",
				-- "jdtls",
				"gradle_ls",
				"jsonls",
				"yamlls",
        "lemminx",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- pythoh linter
				"eslint_d", -- js linter
				"svelte", -- svelte language server
			},
		})
	end,
}
