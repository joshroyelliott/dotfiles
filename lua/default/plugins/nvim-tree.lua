local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- configure nvim-tree
nvimtree.setup({
  -- change folder arrow icons
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = " ",
          arrow_open = " ",
        },
      },
    },
  },
  -- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
