-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-n>",
			node_decremental = "<c-p>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			-- keymaps = {
			-- 	["af"] = "@function.outer",
			-- 	["if"] = "@function.inner",
			-- 	["ac"] = "@class.outer",
			-- 	["ic"] = "@class.inner",
			-- },
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]m"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m]"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[m"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	},
	autotag = { enable = true },
	ensure_installed = {
		"python",
		"json",
		"javascript",
		"yaml",
		"html",
		"css",
		"markdown",
		"bash",
		"lua",
		"vim",
		"gitignore",
	},
	auto_install = true,
})
