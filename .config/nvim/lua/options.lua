require "nvchad.options"

-- Clipboard

local uname = vim.loop.os_uname().sysname
local is_ssh = (vim.env.SSH_TTY ~= nil) or (vim.env.SSH_CONNECTION ~= nil)
-- local in_tmux = (vim.env.TMUX ~= nil)
local in_vscode = (vim.env.TERM_PROGRAM == "vscode")

local function enable_osc52()
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52") -- nvim 0.10+
  if ok then
    vim.g.clipboard = {
      name = "OSC 52",
      copy = { ["+"] = osc52.copy "+", ["*"] = osc52.copy "*" },
      paste = { ["+"] = osc52.paste "+", ["*"] = osc52.paste "*" },
    }
  end
end

-- For VSCode Remote SSH clipboard support macOS <> Linux
-- Use OSC52 if we're remote (or inside tmux when remote).
-- Locally on macOS, don't override clipboard; macOS provider (pbcopy/pbpaste) is fastest/stablest.
if is_ssh or (in_vscode and uname ~= "Darwin") then
  enable_osc52()
end

-- Let yanks use the + register by default everywhere
vim.opt.clipboard = "unnamedplus"

-- Cursor
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.guicursor = ""

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Undo, backup, and swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true

-- Miscellaneous
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append "@-@"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Text wrapping
vim.opt.wrap = false -- Generally do not text wrap

-- Indentation and Syntax

--vim.opt.tabstop = 4
--vim.opt.softtabstop = 4
--vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
--vim.opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "js", "ts", "html", "css", "svelte" },
  callback = function()
    vim.opt_local.tabstop = 2
  end,
})

vim.g.c_syntax_for_h = 1 -- apply C syntax for header files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 0
    vim.opt_local.softtabstop = 0
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "rst" },
  callback = function()
    vim.wo.wrap = true -- Enable line wrapping
    vim.wo.linebreak = true -- Break lines at word boundaries
  end,
})

-- Assembly languages

local function asm_dialect(path)
  -- TODO: Maybe determine based on an env var instead?
  -- Determine based on path
  if path:find("/SMS/", 1, true) then
    return "z8a" -- Z80 under dir SMS/
  elseif path:find("/MD/", 1, true) then
    return "asm68k" -- 68k under dir MD/
  end

  -- NOTE: Could sniff lines of a second param, bufnr,
  -- but probably not worth it.

  -- implicit return nil -> Neovim built-in detection
  -- A file comment can override filetype detection e.g `; vim: ft=z8a`
  return "asm" -- explicitly fall back on GNU asm
end

vim.filetype.add {
  extension = {
    z80 = "z8a",
    s = asm_dialect,
    asm = asm_dialect,
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "asm", "z8a", "asm68k" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
    vim.opt_local.commentstring = "; %s"
  end,
})
