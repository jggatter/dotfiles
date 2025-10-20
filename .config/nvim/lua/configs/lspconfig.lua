-- Load NvChad LSP defaults
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require("nvchad.configs.lspconfig")

-- List of servers to setup with default config
local servers = { "html", "cssls", "ts_ls", "ruff_lsp" }

for _, name in ipairs(servers) do
  vim.lsp.config(name, {
    on_attach    = nvlsp.on_attach,
    on_init      = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(name)
end

-- Go (gopls) with special semanticTokens fix
vim.lsp.config("gopls", {
  on_attach    = nvlsp.on_attach,
  on_init      = function(client, _)
    if client.name == "gopls" then
      if not client.server_capabilities.semanticTokensProvider then
        local semantic = client.config.capabilities.textDocument.semanticTokens
        client.server_capabilities.semanticTokensProvider = {
          full   = true,
          legend = {
            tokenModifiers = semantic.tokenModifiers,
            tokenTypes     = semantic.tokenTypes,
          },
          range = true,
        }
      end
    end
    -- also call the standard on_init
    if nvlsp.on_init then
      return nvlsp.on_init(client, _)
    end
  end,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      semanticTokens = true,
      usePlaceholders = true,
      analyses = {
        unusedvariable = true,
      },
      staticcheck = true,
      hints = {
        assignVariableTypes      = true,
        compositeLiteralFields   = true,
        compositeLiteralTypes    = true,
        constantValues           = true,
        functionTypeParameters   = true,
        parameterNames           = true,
        rangeVariableTypes       = true,
      },
    },
  },
})
vim.lsp.enable("gopls")
