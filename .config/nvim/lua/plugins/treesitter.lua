return {
    "nvim-treesitter/nvim-treesitter", 
    branch = 'master', 
    lazy = false, 
    opts = {
        highlight = {
            enable = true, -- enable highlight by default
            additional_vim_regex_highlighting = false,
        },
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "typescript" },
        sync_install = false,
        auto_install = true,
        indent = {enable=true},
    },
    config = function(_,opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
    build = ":TSUpdate",
}
