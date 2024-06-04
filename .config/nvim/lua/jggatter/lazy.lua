local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  {'theprimeagen/harpoon'},
  {'mbbill/undotree'},
  {'tpope/vim-fugitive'},
  {
    'VonHeikemen/lsp-zero.nvim',
    version = 'v3.x',
	dependencies = {
	  -- LSP Support
	  'neovim/nvim-lspconfig',
	  'williamboman/mason.nvim',
	  'williamboman/mason-lspconfig.nvim',

	  -- Autocompletion
	  'hrsh7th/nvim-cmp',
	  'hrsh7th/cmp-buffer',
	  'hrsh7th/cmp-path',
	  'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

	   -- Snippets
	  --'L3MON4D3/LuaSnip',
	  --'rafamadriz/friendly-snippets',
    }
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", 
      lazy = true,
      --ft = "markdown",
      -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
      event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre " .. vim.fn.expand "~" .. "/Notes/**.md",
        "BufNewFile " .. vim.fn.expand "~" .. "/Notes/**.md",
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      opts = {
        workspaces = {
          {
            name = "personal",
            path = vim.fn.expand "~" .. "/Notes",
          },
        },
      },
  },
  -- Colorschemes
  {'rose-pine/neovim', name = 'rose-pine'},
  --{'folke/tokyonight.nvim', lazy = false, priority = 1000},
  --{'ellisonleao/gruvbox.nvim', priority = 1000, config = true},
  --{'shaunsingh/nord.nvim'},
  {'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {'Mofiqul/vscode.nvim'},
})

