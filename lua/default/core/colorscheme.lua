local status_nightfly, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status_nightfly then
	print("Colorscheme not found!")
	return
end

local status_tokyonight, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status_tokyonight then
	print("Colorscheme not found!")
	return
end
