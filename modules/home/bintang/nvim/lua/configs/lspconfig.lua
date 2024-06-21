local lspconfig = require("lspconfig")
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  ["clangd"] = {},
  ["rust_analyzer"] = {},
  ["gopls"] = {},
  ["nil_ls"] = {},
  ["gdscript"] = {},
  ["ols"] = {},
  ["tsserver"] = {},
  ["lua_ls"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
}

return {
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    vim.diagnostic.enable(true)

    for name, args in pairs(servers) do
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
}
