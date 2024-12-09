require "nvchad.options"


--
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.guicursor = ''

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- Text wrapping
vim.opt.wrap = false -- Generally do not text wrap

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"markdown", "rst"},
    callback = function()
        vim.wo.wrap = true  -- Enable line wrapping
        vim.wo.linebreak = true  -- Break lines at word boundaries
    end,
})

-- 
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

--
vim.opt.termguicolors = true

--
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

