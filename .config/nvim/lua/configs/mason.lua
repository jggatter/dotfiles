local opts = {
  cmd = true,
  pkgs = {
    -- Lua
    "lua-language-server",
    "stylua",

    -- Web Development
    "html-lsp", "css-lsp", "prettier",
    "typescript-language-server",
    "svelte-language-server",

    -- Python
    "pyright",
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
