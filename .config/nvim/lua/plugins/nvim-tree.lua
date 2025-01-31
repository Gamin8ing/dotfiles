return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- recommended nvim.tree setup
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1


    require("nvim-tree").setup {
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      view = {
        width = 30, -- initial width of the file explorer window,
      },
      filters = {
        dotfiles = true,
        custom = {".DS_Store"},
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
    }

    -- some keymaps for nvim-tree are in config/keymaps.lua 
  end,
}
