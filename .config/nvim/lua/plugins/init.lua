return {
	"nvim-lua/plenary.nvim",
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			smear_insert_mode = false,
			egacy_computing_symbols_support = true,
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{ "echasnovski/mini.icons", version = "*" },
	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
		"numToStr/Comment.nvim",
		vent = { "BufReadPre", "BufNewFile" },
		opts = {
			-- add any options here
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
