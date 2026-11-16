--- LSPs.

---@type PluginConfig
return {
  spec = {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
  },

  config = function()
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

    vim.diagnostic.config({
      virtual_text = false,
    })
    vim.diagnostic.enable(true)

    for name, args in pairs(languages.lsp_servers()) do
      local config = args

      if args.on_init ~= nil then
        config.on_init = function(client, result)
          -- Disable semanticTokens
          if client.supports_method("textDocument/semanticTokens") then
            client.server_capabilities.semanticTokensProvider = nil
          end

          args.on_init(client, result)
        end
      end

      config.capabilities =
        vim.tbl_extend("force", capabilities, args.capabilities or {})

      vim.lsp.config[name] = config
      vim.lsp.enable(name)
    end
  end,

  base46 = "lsp",
}
