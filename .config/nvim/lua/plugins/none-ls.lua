return {
	"nvimtools/none-ls.nvim",
	config = function()
		-- none-ls is a fork of null-ls, hence the name sharing
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- stylua installed via Mason
				-- :Mason, /stylua, i
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.clang_format,
			},
		})
	end,
}
