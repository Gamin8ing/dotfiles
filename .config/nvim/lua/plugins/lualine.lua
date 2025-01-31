return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "palenight",
		sections = {
			lualine_c = {
				"filename",
				"searchcount",
				"selectioncount",
			},
		},
		tabline = {
			lualine_b = {}, --"windows" }, -- 'buffers'},
			lualine_a = {
				{
					"windows",
					filetype_names = {
						alpha = "Hello, Bhavya",
						TelescopePrompt = "Searching..",
						fzf = "FZF",
						dashboard = "Dash",
					},
				},
			},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { {
				"tabs",
				mode = 2,
			} },
		},
		globalstatus = true,
		extensions = { "nvim-tree" },
	},
}
