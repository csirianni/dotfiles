return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            lspconfig.clangd.setup({
                capabilities = capabilities,
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.pyright.setup({
                capabilities = capabilities,
                -- Use Ruff exclusively for linting, formatting, and organizing imports.
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

            lspconfig.ruff.setup({
                capabilities = capabilities,
            })

            -- lspconfig.rust_analyzer.setup({
            -- 	capabilities = capabilities,
            -- 	settings = {
            -- 		["rust-analyzer"] = {
            -- 			cargo = {
            -- 				features = "all",
            -- 			},
            -- 			imports = {
            -- 				group = {
            -- 					enable = false,
            -- 				},
            -- 			},
            -- 			completion = {
            -- 				postfix = {
            -- 					enable = false,
            -- 				},
            -- 			},
            -- 			diagnostics = {
            -- 				enable = true,
            -- 			},
            -- 		},
            -- 	},
            -- })

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
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set({ "n" }, "gs", ":ClangdSwitchSourceHeader<CR>")
        end,
    },
}
