-- Print the line number in front of each line
vim.opt.number = true
-- Show the line number relative to the current line
vim.opt.relativenumber = true
-- Always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = "yes"
-- Infinite undo
vim.opt.undofile = true
-- Set tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- Expand tabs to spaces
vim.opt.expandtab = true
-- Case-insensitive search/replace
vim.opt.ignorecase = true
-- Unless uppercase in search term
vim.opt.smartcase = true
vim.opt.smartindent = true
-- Wrap lines
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 100
vim.opt.wrapmargin = 0
vim.opt.colorcolumn = "100"
-- Set highlight on search, but clear on pressing <Esc> or <C-c> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")
-- Show matching results as you type
vim.opt.incsearch = true
-- Enable 24-bit RGB color in the terminal for actual colors
vim.opt.termguicolors = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.lsp.log.set_level = "off"
-------------------------------------------------------------------------------
--
-- Autocommands
--
--------------------------------------------------------------------------------

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
})

-- Jump to last edit position on opening file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            -- except for in git commit messages
            -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
            if not vim.fn.expand("%:p"):find(".git", 1, true) then
                vim.cmd('exe "normal! g\'\\""')
            end
        end
    end,
})
