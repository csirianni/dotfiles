-- The default local leader key is \. See :help vimtex for more info.
-- To live preview, \lv.
-- To start continuous compilation, \ll.

return {
	"lervag/vimtex",
	init = function()
		-- Use init for configuration, don't use the more common "config".
		vim.g.vimtex_view_method = "skim"
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_quickfix_open_on_warning = 0
	end,
}
