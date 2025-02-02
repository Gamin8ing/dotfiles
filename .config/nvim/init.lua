require("config.options") -- loading options for nvim
require("config.keymaps") -- global keymaps to set
require("config.lazy") -- loading lazy
-- hello from another world

-- clangd fix
local cmp_nvim_lsp = require("cmp_nvim_lsp")
require("lspconfig").clangd.setup({
	capabilities = cmp_nvim_lsp.default_capabilities(),
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})
