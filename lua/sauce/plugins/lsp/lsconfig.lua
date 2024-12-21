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
		local util = lspconfig.util

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
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				-- Java keymaps
				opts.desc = "Build workspace"
				keymap.set("n", "<leader>jbw", ":JavaBuildBuildWorkspace<CR>", opts) -- build workspace
				opts.desc = "Clean workspace"
				keymap.set("n", "<leader>jcw", ":JavaBuildCleanWorkspace<CR>", opts) -- clean workspace
        opts.desc = "DAP config"
        keymap.set("n", "<leader>jd", ":JavaDapConfig<CR>", opts) -- DAP config
				opts.desc = "Run app"
				keymap.set("n", "<leader>jr", ":JavaRunnerRunMain<CR>", opts) -- run
				opts.desc = "Stop app"
				keymap.set("n", "<leader>js", ":JavaRunnerStopMain<CR>", opts) -- stop
				opts.desc = "Toggle logs"
				keymap.set("n", "<leader>jlt", ":JavaRunnerToggleLogs<CR>", opts) -- toggle logs
				opts.desc = "Switch logs"
				keymap.set("n", "<leader>jls", ":JavaRunnerSwitchLogs<CR>", opts) -- switch app
				opts.desc = "Extract variable"
				keymap.set("n", "<leader>jev", ":JavaRefactorExtractVariable<CR>", opts) -- stop
				opts.desc = "Extract method"
				keymap.set("n", "<leader>jem", ":JavaRefactorExtractMethod<CR>", opts) -- stop
				opts.desc = "Extract constant"
				keymap.set("n", "<leader>jec", ":JavaRefactorExtractConstant<CR>", opts) -- stop
				opts.desc = "Extract field"
				keymap.set("n", "<leader>jef", ":JavaRefactorExtractField<CR>", opts) -- stop
				opts.desc = "Change runtime"
				keymap.set("n", "<leader>jcr", ":JavaSettingsChangeRuntime<CR>", opts) -- stop
			end,
		})

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
		})
	end,
}
