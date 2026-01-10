-- return {
--     -- setting up dracula as my main colorscheme
--     'Mofiqul/dracula.nvim',
--     lazy = false,
--     priority = 1000,
--     opts = {
--         show_end_of_buffer = true, 
--         transparent_bg = true, -- setting up transparency
--     },
-- }
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = false,
        })
    end,
}
