local none_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    none_ls.builtins.diagnostics.mypy.with({
      extra_args = function()
        local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
        return { "--python-executable", virtual .. "/bin/python3" }
      end,
    }),

    -- Go
    none_ls.builtins.formatting.gofmt,
    none_ls.builtins.formatting.goimports,
    none_ls.builtins.formatting.golines,

    -- TypeScript / JavaScript
    none_ls.builtins.formatting.prettier,
  },
  -- Automatically format Go code upon write
  on_attach = function(client, bufnr)
    if client.name == "gopls" and client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}

return opts
