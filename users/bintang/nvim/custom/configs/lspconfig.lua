local M = {}

M.setup = function(lspconfig, on_attach, capabilities)
  local servers = {
    "clangd",
    "rust_analyzer",
    "gopls",
    "nil_ls",
    "gdscript",
  }

  for _, lsp in ipairs(servers) do lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
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
