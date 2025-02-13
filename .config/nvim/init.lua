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

-- --------- LuaSnip Config -------------------
--
-- configuring luasnips snippet?
require("luasnip").config.set_config({ --setting luasnip config
	enable_autosnippets = true,
	--enable autotriggered snippets
	store_selection_keys = "<Tab>",
	update_events = "TextChanged,TextChangedI",
})

-- loading all snippets from custom directory at startup
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

-- lazy load the snippets, i.e. only when certain filetypes are open
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })
