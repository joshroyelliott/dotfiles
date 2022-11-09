-- import nvim-autopairs safely
local setup, indent_blankline = pcall(require, "indent_blankline")
if not setup then
	return
end

indent_blankline.setup({
	char = "┊",
	show_trailing_blankline_indent = false,
})
