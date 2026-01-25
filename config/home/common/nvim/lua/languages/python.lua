---@type LanguageConfig
return {
  lsp_name = "pylsp",
  formatter = "black",
  indent = 4,
  lsp_config = {
    settings = {
      pylsp = {
        plugins = {
          mccabe = {
            enabled = false,
          },
          pycodestyle = {
            maxLineLength = 100,
            ignore = { "E203" },
          },
        },
      },
    },
  },
}
