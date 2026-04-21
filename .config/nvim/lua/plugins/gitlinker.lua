require("gitlinker").setup({})

for _, mode in ipairs({ "n", "v" }) do
    vim.keymap.set(
        mode,
        "<leader>glc",
        "<cmd>GitLink current_branch<cr>",
        { desc = "[G]it[L]ink [C]urrent branch" }
    )
    vim.keymap.set(
        mode,
        "<leader>gld",
        "<cmd>GitLink default_branch<cr>",
        { desc = "[G]it[L]ink [D]efault branch" }
    )
end
