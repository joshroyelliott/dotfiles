-- we're basically returning a table!
return {

  ["christoomey/vim-tmux-navigator"] = {},
  ["tpope/vim-unimpaired"] = {},
  ["tpope/vim-surround"] = {},
  ["tpope/vim-repeat"] = {},
  ["folke/zen-mode.nvim"] = {},

  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end, ft = { "markdown" },
  },
  ["folke/twilight.nvim"] = {},


  ["kblin/vim-fountain"] = {},
}
