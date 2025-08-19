return {
    "nvim-tree/nvim-tree.lua", 
    dependencies = {
        { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    opts = {
        filters = {
            dotfiles = true,
        },
        view = {
            width = 30,
        },
    },
    config = function() 
        require("nvim-tree").setup(opts);
    end,
}
-- TODO: add more bug fixes
