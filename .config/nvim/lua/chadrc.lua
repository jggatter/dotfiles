-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark",

	hl_override = {
		Comment = { italic = false },
		["@comment"] = { italic = false },
		["@constant"] = { fg = "nord_blue" },
		-- Type = {fg = "#4EC9B0"},
	},
}

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
