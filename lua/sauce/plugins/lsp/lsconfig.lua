return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		-- Keymaps for LSP
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" }) -- show definition, references
				keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }) -- go to declaration
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" }) -- show lsp definitions
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" }) -- show lsp implementations
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" }) -- show lsp type definitions

				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" }) -- see available code actions, in visual mode will apply to selection

				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" }) -- smart rename

				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Show buffer diagnostics" }
				) -- show  diagnostics for file
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" }) -- show diagnostics for line
				keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" }) -- jump to previous diagnostic in buffer
				keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer

				keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor

				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary

				-- Java keymaps
				keymap.set("n", "<leader>jvbw", ":JavaBuildBuildWorkspace<CR>", { desc = "Build workspace" }) -- build workspace
				keymap.set("n", "<leader>jvcw", ":JavaBuildCleanWorkspace<CR>", { desc = "Clean workspace" }) -- clean workspace
				keymap.set("n", "<leader>jvd", ":JavaDapConfig<CR>", { desc = "DAP config" }) -- DAP config
				keymap.set("n", "<leader>jvr", ":JavaRunnerRunMain<CR>", { desc = "Run app" }) -- run
				keymap.set("n", "<leader>jvs", ":JavaRunnerStopMain<CR>", { desc = "Stop app" }) -- stop
				keymap.set("n", "<leader>jvtl", ":JavaRunnerToggleLogs<CR>", { desc = "Toggle logs" }) -- toggle logs
				keymap.set("n", "<leader>jvcr", ":JavaSettingsChangeRuntime<CR>", { desc = "Change runtime" }) -- stop

				-- Flutter keymaps
				keymap.set("n", "<leader>flr", ":FlutterRun<CR>", { desc = "Run flutter" }) -- run
				keymap.set("n", "<leader>fls", ":FlutterQuit<CR>", { desc = "Stop flutter" }) -- stop
				keymap.set("n", "<leader>fle", ":FlutterEmulators<CR>", { desc = "Emulators" }) -- emulator
				keymap.set("n", "<leader>fld", ":FlutterDevices<CR>", { desc = "Devices" }) -- devices
				keymap.set("n", "<leader>fltl", ":FlutterLogToggle<CR>", { desc = "Toggle log" }) -- toggle log
			end,
		})

		local on_attach = function(client, bufnr)
			-- format on save
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("Format", { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["cssls"] = function()
				-- configure css language server
				lspconfig["cssls"].setup({
					capabilities = capabilities,
					cmd = { "vscode-css-language-server", "--stdio" },
					filetypes = { "css", "scss", "less" },
					settings = {
						css = {
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = {
							lint = {
								unknownAtRules = "ignore",
							},
						},
						less = {
							lint = {
								unknownAtRules = "ignore",
							},
						},
					},
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						if client.name == "svelte" then
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
								callback = function(ctx)
									-- Here use ctx.match instead of ctx.file
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end,
							})
						end
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["jdtls"] = function()
				-- configure java server
				lspconfig["jdtls"].setup({
					capabilities = capabilities,
					settings = {
						java = {
							configuration = {
								runtimes = {
									{
										name = "JavaSE-11",
										path = "/usr/lib/jvm/java-11-openjdk",
									},
									{
										name = "JavaSE-23",
										path = "/usr/lib/jvm/java-23-openjdk",
									},
								},
							},
							format = {
								enabled = true,
								settings = {
									url = "./formats/java.xml",
								},
							},
						},
					},
				})
			end,
			["yamlls"] = function()
				-- configure yaml server
				lspconfig["yamlls"].setup({
					capabilities = capabilities,
					settings = {
						yaml = {
							schemas = {
								kubernetes = "*.yaml",
							},
						},
					},
				})
			end,
			["pyright"] = function()
				-- configure python server
				lspconfig["pyright"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
