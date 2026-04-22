-- Auto-install treesitter parsers when opening a file that needs one
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local ft = vim.bo.filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft

        -- Skip if parser is already available
        if pcall(vim.treesitter.language.inspect, lang) then
            return
        end

        -- Check if nvim-treesitter knows about this parser
        local ok, parsers = pcall(require, "nvim-treesitter.parsers")
        if ok and parsers[lang] then
            require("nvim-treesitter.install").install({ lang })
        end
    end,
})

-- Use treesitter highlighting and indentation
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
