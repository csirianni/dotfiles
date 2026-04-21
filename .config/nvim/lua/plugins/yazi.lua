-- Block netrw plugin load
vim.g.loaded_netrwPlugin = 1

require("yazi").setup({
    open_for_directories = true,
})

vim.keymap.set({ "n", "v" }, "<leader>pv", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
