return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-y>"] = require("telescope.actions").select_default,
                        }
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, {})
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
            vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
            vim.keymap.set("n", "<leader>fe", function()
                builtin.diagnostics({
                    bufnr = 0,
                    severity = vim.diagnostic.severity.ERROR
                })
            end, { desc = "[F]ind [E]rrors" })
            vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", {})
            vim.keymap.set("n", "<C-t>", builtin.treesitter, {})
            vim.keymap.set("n", "gr", builtin.lsp_references, {})

            telescope.load_extension("ui-select")
            telescope.load_extension("live_grep_args")
        end,
    },
}
