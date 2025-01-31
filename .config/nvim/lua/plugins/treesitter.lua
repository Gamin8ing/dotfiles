return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    -- ensure these langs are installed
    ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "jsx",
      "tsx",
      "html",
      "css",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "dockerfile",
      "gitignore",
      "c",
      "cpp",
      "python",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>", -- set to `false` to disable one of the mappings
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
  },
}
