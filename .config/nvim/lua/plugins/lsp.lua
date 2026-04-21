local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Apply cmp capabilities to all LSP servers
vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

vim.lsp.config("clangd", {
    cmd = {
        "/opt/mongodbtoolchain/v5/bin/clangd",
        "--background-index=true",
        "--background-index-priority=low",
        "--malloc-trim",
        "-j=1",
    },
})

vim.lsp.config("pyright", {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
            },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "bashls",
    "clangd",
    "ts_ls",
    "pyright",
    "ruff",
    "rust_analyzer",
})

-- Defer to pyright for hover
-- https://docs.astral.sh/ruff/editors/setup/#neovim
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = "LSP: Disable hover capability from Ruff",
})

vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set({ "n" }, "gs", ":ClangdSwitchSourceHeader<CR>")
