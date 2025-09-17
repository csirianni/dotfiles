return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        keywords = {
            CEDRIC = { icon = " ", color = "default" },
        },
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*:|\s(KEYWORDS)\s]],
        }
    },
}
