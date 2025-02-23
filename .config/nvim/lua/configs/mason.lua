local opts = {
  cmd = true,
  pkgs = {
    -- Lua
    "lua-language-server",
    "stylua",

    -- Web Development
    "html-lsp", "css-lsp" , "prettier",

    -- Python
    "ruff",
    "mypy",

    -- Go
    "gopls",
    "goimports",
    "golines",

    -- Rust
    "rust-analyzer",
  },
}

return opts
