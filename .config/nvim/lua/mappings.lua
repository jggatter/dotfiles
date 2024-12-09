require "nvchad.mappings"

-- NvChad for some reason wants to bind ^c to copy whole file
vim.keymap.del("n", "<C-c>")

-- Alternate command mode
vim.keymap.set("n", ";", ":", {desc = "CMD Enter command mode"})

-- Explorer (Disabled by Nvchad)
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected text with auto-indent
vim.keymap.set(
  "v", "J", ":m '>+1<CR>gv=gv",
  {desc = "Move selection down a line and auto-indent"}
)
vim.keymap.set(
  "v", "K", ":m '<-2<CR>gv=gv",
  {desc = "Move selection up a line and auto-ident"}
)

-- Take line below and append it to current line
vim.keymap.set(
  "n", "J", "mzJ`z",
  {desc = "Move above line and append to current line"}
)

-- Half-page jumping but keep cursor in middle of screen
vim.keymap.set(
  "n", "<C-d>", "<C-d>zz",
  {desc = "Jump half-page down while keeping cursor centered"}
)
vim.keymap.set(
  "n", "<C-u>", "<C-u>zz",
  {desc = "Jump half-page up while keeping cursor centered"}
)

-- Allow search term to stay in middle of screen while cycling
vim.keymap.set(
  "n", "n", "nzzzv",
  {desc = "Jump to next search term keeping cursor centered"}
)
vim.keymap.set(
  "n", "N", "Nzzzv",
  {desc = "Jump to previous search term keeping cursor centered"}
)

-- Avoid copying while pasting over highlighted word
vim.keymap.set(
  "x", "<leader>p", "\"_dP",
  {desc = "Paste over selection without copying"}
)

-- Copy to the system clipboard
-- by asbjornHaland
vim.keymap.set(
  {"n", "v"}, "<leader>y", [["+y]],
  {desc = "Copy to system clipboard"})
vim.keymap.set(
  "n", "<leader>Y", [["+Y]],
  {desc = "Copy ??? to system clipboard"}
)

-- Deleting to void register
vim.keymap.set(
  {"n", "v"}, "<leader>d", [["_d]],
  {desc = "Delete without copying"}
)

-- Highlight and start substituting all instances of a word in file
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    {desc = "Substitute all instances of a word in file"}
)

-- Source the current file
vim.keymap.set(
  "n",
  "<leader><leader>",
  function() vim.cmd("so") end,
  {desc = "Source the current file"}
)
