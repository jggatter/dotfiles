return {
  -- Improved formatting. This and nvim-lint are alternative to none-ls
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- Integration of tree-sitter parsing tool for highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      local plugin = require("lazy.core.config").plugins["nvim-treesitter"]

      if plugin and plugin.dir then
        vim.opt.rtp:append(plugin.dir .. "/runtime")
      end

      require("nvim-treesitter").setup(opts)
    end,
    opts = {
      highlight = {
        enable = true,
      },
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "javascript",
        "typescript", "svelte",
        "python", "go", "rust",
        "toml", "yaml", "json", "xml",
        "dockerfile", "dot", "sql"
      },
    },
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
