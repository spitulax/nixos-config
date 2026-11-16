local clangd_allowlist = {
  vim.env.HOME .. "/.platformio/packages/toolchain-*/bin/*",
  "/nix/store/*gcc-wrapper*/bin/*",
  "/nix/store/*clang-wrapper*/bin/*",
}

---@type LanguageConfig
return {
  fts = {
    "c",
    "cpp",
  },
  lsp_name = "clangd",
  formatter = "clang-format",
  indent = 4,
  lsp_config = {
    cmd = {
      "clangd",
      "--query-driver=" .. table.concat(clangd_allowlist, ","),
    },

    reuse_client = function(client, config)
      if
        client.name == config.name
        and client.config.root_dir == config.root_dir
      then
        return true
      end
      -- Reuse client if the new buffer has no root_dir (e.g. external headers)
      if client.name == config.name and config.root_dir == nil then
        return true
      end
      return false
    end,
  },
}
