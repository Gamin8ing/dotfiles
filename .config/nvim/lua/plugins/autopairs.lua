return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    opts = {
        enable_check_bracket_line = false,
    },
    -- this is equivalent to setup({}) function
}
