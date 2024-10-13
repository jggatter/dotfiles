return {
  -- Improved formatting. This and nvim-lint are alternative to none-ls
  -- {
  --   "stevearc/conform.nvim",
  --   -- event = 'BufWritePre', -- uncomment for format on save
  --   opts = require "configs.conform",
  -- },
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
  -- none-ls fka null-ls integrates LSP-related sources
  {
    "nvimtools/none-ls.nvim",
    ft = { "python", "go" },
    opts = function()
      return require "configs.none_ls"
    end,
  },
  -- Mason installs external dependencies to Neovim
  {
  	"williamboman/mason.nvim",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
}
