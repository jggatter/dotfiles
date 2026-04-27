-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "cssls", "html", "pyright", "svelte", "ts_ls" }

local default_opts = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, default_opts)
  vim.lsp.enable(lsp)
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- python
vim.lsp.config("ruff", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})
vim.lsp.enable "ruff"

-- go
vim.lsp.config("gopls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    gopls = {
      semanticTokens = true,  -- experimental
      usePlaceholders = true,
      analyses = {
        unusedvariable = true,
      },
      staticcheck = true,  -- experimental
      hints = {  --experimental
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    }
  }
})
vim.lsp.enable "gopls"
