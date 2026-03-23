require("config.lazy") -- loading lazy
require("config.keymaps") -- global keymaps to set
require("config.options") -- loading options for nvim
require("config.cp_setup") -- loading cp setup

vim.cmd([[colorscheme catppuccin-mocha]])

vim.lsp.enable({"lua_ls", "clangd", "eslint", "pyright", "ts_ls", "asm_lsp"})
