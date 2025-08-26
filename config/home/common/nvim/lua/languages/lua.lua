---@type LanguageConfig
return {
  lsp_name = "lua_ls",
  lsp_config = {
    settings = {
      Lua = {
        runtime = {
          version = "Lua 5.1",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
  formatter = "stylua",
}
