return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- configuring mason icons and enabling mason
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- setting up lspconfig with mason to communicate with vim.lsp
		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"clangd", -- for C/C++ - includes linting by default
				"cssls",
				"tailwindcss",
				"lua_ls",
				"pyright",
				"emmet_ls",
			},
		})

		-- setting up mason tool installer
		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd", -- prettierd in place of prettier first
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js/ts linter
			},
		})
	end,
}
