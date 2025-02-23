-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark_true", -- Custom theme
}
original_theme = M.base46.theme
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"*"},
    callback = function()
       require("nvconfig").base46.theme = original_theme
       require("base46").load_all_highlights()
    end,
})
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"rust"},
    callback = function()
       require("nvconfig").base46.theme = 'gruvbox'
       require("base46").load_all_highlights()
    end,
})

M.ui = {
  statusline = {
    -- theme = "minimal" -- Shows ruler
    theme = "vscode_colored"
  },
  tabufline = {
    -- disable in favor of using tmux windows
    enabled = false,
  },
}

M.mason = require 'configs.mason'

return M
