return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            section_separators = '',
            component_separators = '',
            extensions = { "nvim-tree" },
            disabled_filetypes = { statusline = { 'NvimTree' } }, -- disabling in nvim tree
        },
    }
}
