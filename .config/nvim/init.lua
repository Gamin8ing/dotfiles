require("config.lazy") -- loading lazy
require("config.keymaps") -- global keymaps to set
require("config.options") -- loading options for nvim

vim.cmd([[colorscheme dracula]])

vim.lsp.enable({"lua_ls", "clangd"})

