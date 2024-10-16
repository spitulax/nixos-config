--- LSPs.

---@type PluginConfig
return {
  spec = { "neovim/nvim-lspconfig" },

  config = function()
    local languages = require("internals.languages")
    local lspconfig = require("lspconfig")
    -- local on_attach = require("nvchad.configs.lspconfig").on_attach
    local on_init = require("nvchad.configs.lspconfig").on_init
    local capabilities = require("nvchad.configs.lspconfig").capabilities

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
      -- if args.on_attach ~= nil then
      --   on_attach = args.on_attach
      -- end
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
}
