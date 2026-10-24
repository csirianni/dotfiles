require("todo-comments").setup({
    keywords = {
        CEDRIC = { icon = " ", color = "default" },
    },
    highlight = {
        before = "fg",
        keyword = "bg",
        pattern = {
            [[.{-}(\s?<(KEYWORDS)\s*:)]],
            [[.{-}(\s?<(KEYWORDS)\s*\([A-Z]+-\d+\)\s*:)]],
            [[.{-}(\s?<(KEYWORDS)\s+[A-Z]+-\d+\s*:)]],
        },
    },
    search = {
        pattern = [[\b(KEYWORDS)(\s*\([A-Z]+-\d+\)\s*:|\s+[A-Z]+-\d+\s*:|\s*):]],
    },
})

local Config = require("todo-comments.config")
local Highlight = require("todo-comments.highlight")

local highlight = Highlight.highlight
Highlight.highlight = function(buf, first, last, event)
    highlight(buf, first, last, event)
    local marks = vim.api.nvim_buf_get_extmarks(buf, Config.ns, { first, 0 }, { last, 0 }, { details = true })
    for _, mark in ipairs(marks) do
        local hl = mark[4].hl_group
        if mark[3] > 0 and hl:sub(1, 6) == "TodoFg" then
            local has_badge = false
            for _, other in ipairs(marks) do
                if other[2] == mark[2]
                    and other[4].end_col == mark[3]
                    and other[4].hl_group:sub(1, 6) == "TodoBg" then
                    has_badge = true
                end
            end
            if not has_badge then
                vim.api.nvim_buf_set_extmark(buf, Config.ns, mark[2], 0, {
                    end_col = mark[3],
                    hl_group = hl,
                    priority = 500,
                })
            end
        end
    end
end
