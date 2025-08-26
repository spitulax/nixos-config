--- LSPs.

---@type PluginConfig
return {
  spec = {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
  },

  config = function()
    local function on_attach()
      -- nothing
    end

    local function on_init(client, _)
      -- Disable semanticTokens
      if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    require("nvchad.lsp").diagnostic_config()

    local languages = require("internals.languages")
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({
      virtual_text = false,
    })
    vim.diagnostic.enable(true)

    for name, args in pairs(languages.lsp_servers()) do
      local settings = {}

      if args.settings ~= nil then
        settings = args.settings
      end
      if args.on_init ~= nil then
        on_init = args.on_init
      end
      if args.on_attach ~= nil then
        on_attach = args.on_attach
      end
      if args.capabilities ~= nil then
        capabilities = args.capabilities
      end

      lspconfig[name].setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings,
      })
    end
  end,

  base46 = "lsp",
}
