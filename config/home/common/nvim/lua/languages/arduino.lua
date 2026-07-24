---@type LanguageConfig
return {
  lsp_name = "arduino_language_server",
  lsp_config = {
    capabilities = {
      textDocument = {
        semanticTokens = vim.NIL,
      },
      workspace = {
        semanticTokens = vim.NIL,
      },
    },
    cmd = {
      "arduino-language-server",
      "-cli-config",
      vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
      "-fqbn",
      "esp8266:esp8266:nodemcuv2",
      "-cli",
      "arduino-cli",
      "-clangd",
      "clangd",
    },
  },
  formatter = "clang-format",
  indent = 4,
}
