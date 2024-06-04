return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require("lua.configs.none_ls")
    end,
  },
  -- Mason installs external dependencies to Neovim
  {
  	"williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lua
        "lua-language-server",
        "stylua",

        -- Web Development
        -- "html-lsp", "css-lsp" , "prettier"

        -- Python
        "ruff",
        "mypy",
  	  },
    },
  },

--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = {
--       ensure_installed = {
--         "vim", "lua", "vimdoc",
--         "html", "css"
--       },
--     },
--   },

}
