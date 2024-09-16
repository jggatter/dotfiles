return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- Integration of tree-sitter parsing tool for highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python", "go",
      },
    },
  },
  -- null-ls integrates LSP-related sources
  {
    "nvimtools/none-ls.nvim",
    ft = { "python", "go" },
    opts = function()
      return require "lua.configs.none_ls"
    end,
  },
  -- Mason installs external dependencies to Neovim
  {
  	"williamboman/mason.nvim",
  },
}
