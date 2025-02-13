return {
	"nvim-lua/plenary.nvim",
	{
		"sphamba/smear-cursor.nvim",
		enabled = false,
		opts = {
			smear_insert_mode = true,
			legacy_computing_symbols_support = true,
			-- making it more stiff
			stiffness = 0.8,
			trailing_stiffness = 0.6,
			distance_stop_animating = 0.5,
			horizontal_bar_cursor_replace_mode = true,
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
	-- enabling leetcode in neovim
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- configuration goes here
		},
	},
	-- github copilot
	{
		"github/copilot.vim",
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura_simple"
			vim.g.vimtex_view_forward_search_on_start = false
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = "/home/bhavya/.texfiles",
				out_dir = "/home/bhavya/.texfiles",
			}
			vim.g.vimtex_quickfix_open_on_warning = 0 -- to disable quickfix on warning
		end,
	}, -- vimtex for latex + neovim
	{
		"ThePrimeagen/vim-be-good",
	}, -- vim be good to practive the vim movement
	{
		"3rd/image.nvim",
	}, -- to view images in nvim, its not officially supported by wezterm, but lets see
	-- For `plugins.lua` users.
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},
}
-- TODO:
