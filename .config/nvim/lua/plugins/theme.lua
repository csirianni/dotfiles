return {
    { "nvim-tree/nvim-web-devicons" },
    {
        {
            "sainnhe/sonokai",
            name = "sonokai",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("sonokai")
            end,
        },
    },
}
