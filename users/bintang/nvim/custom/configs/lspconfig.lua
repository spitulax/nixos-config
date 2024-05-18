local M = {}

M.setup = function(lspconfig, on_init, on_attach, capabilities)
  local servers = {
    "clangd",
    "rust_analyzer",
    "gopls",
    "nil_ls",
    "gdscript",
    "lua_ls"
  }

  for _, lsp in ipairs(servers) do
    local arg_on_init = on_init
    local arg_on_attach = on_attach
    local arg_capabilities = capabilities
    local arg_settings = {}

    if lsp == "lua_ls" then
      arg_settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      }
    end

    lspconfig[lsp].setup({
      on_init = arg_on_init,
      on_attach = arg_on_attach,
      capabilities = arg_capabilities,
      settings = arg_settings,
    })
  end
end

M.mappings = {
  n = {
    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev diagnostic",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next diagnostic",
    },
  },
}

return M
