vim.o.swapfile = false
vim.opt.rnu = true -- rel numbering
vim.opt.number = true -- absolute line number
vim.opt.clipboard:append("unnamedplus") -- setting up the clipboard

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.cmd(":hi StatusLine guibg=NONE")

vim.opt.scrolloff = 8 -- scroll when only 8 lines remaining instead of going straight to botttom then scroll
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
    -- virtual_text = true,
    float = true,
})
vim.o.winborder = 'rounded'
vim.cmd("set completeopt+=noselect") -- the autocomnplete go crazy

vim.o.undofile = true

