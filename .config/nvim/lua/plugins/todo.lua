require("todo-comments").setup({
    keywords = {
        CEDRIC = { icon = " ", color = "default" },
    },
    highlight = {
        pattern = [[.*<(KEYWORDS)\s*:|\s(KEYWORDS)\s]],
    },
})
