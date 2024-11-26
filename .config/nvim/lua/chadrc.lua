-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark",

	hl_override = {
		Boolean = { fg = "nord_blue" },
		["@constant"] = { fg = "nord_blue" },
		["@constant.builtin"] = { fg = "nord_blue" }, -- None
    ["@property"] = { fg = "cyan" },
    ["@variable.builtin"] = { fg = "cyan" },
    ["@variable.member"] = { fg = "cyan" },
    ["@variable.parameter"] = { fg = "cyan" },
    ["@module"] = { fg = "#4EC9B0" },
    ["@constructor"] = { fg = "#4EC9B0" }, -- Class invocation
		Type = { fg = "#4EC9B0" }, -- Classes
    ["@type.builtin"] = { fg = "#4EC9B0" }, -- str
    Include = { fg = "#C586C0" }, -- from import
    ["@keyword.repeat"] = { fg = "#C586C0" }, -- for
    Special = { fg = "#C586C0" }, -- f-string braces
	}
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
