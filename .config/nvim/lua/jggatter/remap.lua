-- Spacebar is mapleader
vim.g.mapleader = " "

-- Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Cycle colorscheme
vim.keymap.set("n", "<leader>c", function()
    vim.cmd("lua cycleColor()")
end)

-- Move selected text with auto-indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Take line below and append it to current line
vim.keymap.set("n", "J", "mzJ`z")

-- Half-page jumping but keep cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allow search term to stay in middle of screen while cycling
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Avoid copying while pasting over highlighted word
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to the system clipboard
-- by asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deleting to void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Highlight and start substituting all instances of a word in file
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
