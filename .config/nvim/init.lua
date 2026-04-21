vim.g.mapleader = " "

vim.pack.add({
    "https://github.com/sainnhe/sonokai",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/ray-x/lsp_signature.nvim",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim", version = vim.version.range("1.0") },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/stevearc/conform.nvim",
    { src = "https://github.com/ThePrimeagen/harpoon",                         name = "harpoon2",                 version = "harpoon2" },
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/linrongbin16/gitlinker.nvim",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/petertriho/nvim-scrollbar",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/lervag/vimtex",
    "https://github.com/mikavilpas/yazi.nvim",
})

-- Plugin configs
require("plugins.theme")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.lsp_signature")
require("plugins.completions")
require("plugins.telescope")
require("plugins.format")
require("plugins.harpoon")
require("plugins.gitsigns")
require("plugins.gitlinker")
require("plugins.comment")
require("plugins.lualine")
require("plugins.scrollbar")
require("plugins.todo")
require("plugins.vimtex")
require("plugins.yazi")

require("settings")
require("mappings")
