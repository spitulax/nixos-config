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

    vim.diagnostic.config({
      virtual_text = false,
    })
    vim.diagnostic.enable(true)

    for name, args in pairs(languages.lsp_servers()) do
      local config = {}

      if args.settings ~= nil then
        config = vim.tbl_extend("force", config, {
          settings = args.settings,
        })
      end
      if args.on_init ~= nil then
        config = vim.tbl_extend("force", config, {
          on_init = args.on_init,
        })
      end
      if args.on_attach ~= nil then
        config = vim.tbl_extend("force", config, {
          on_attach = args.on_attach,
        })
      end
      if args.capabilities ~= nil then
        config = vim.tbl_extend("force", config, {
          capabilities = args.capabilities,
        })
      end
      if args.cmd ~= nil then
        config = vim.tbl_extend("force", config, {
          cmd = args.cmd,
        })
      end

      vim.lsp.config[name] = config
      vim.lsp.enable(name)
    end
  end,

  base46 = "lsp",
}
