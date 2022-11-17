-- lua/custom/mappings 
local M = {}

-- add this table only when you want to disable default keys
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-s>"] = ""
--   }
-- }

-- M.abc = {
--
--   n = {
--      ["<C-n>"] = {"<cmd> Telescope <CR>", "Open Telescope"}
--   }
--
--   i = {
--     -- more keys!
--   }
-- }

M.xyz = {
  -- stuff
  n = {
    ["<leader>z"] = {"<cmd> ZenMode <CR>", "Toggle Zen Mode"},
    ["<leader>md"] = {"<cmd> MarkdownPreviewToggle <CR>", "Toggle Markdown Preview"}
  }
}

return M
