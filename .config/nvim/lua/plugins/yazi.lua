return {
    "mikavilpas/yazi.nvim",
    keys = {
        {
            "<leader>pv",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
    },
    init = function()
        -- Block netrw plugin load
        -- vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    event = "VeryLazy",
    opts = {
        open_for_directories = true,
    },
}
