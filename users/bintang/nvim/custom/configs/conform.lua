local M = {}

M.opts = {
  formatters_by_ft = {
    go = { "gofmt" },
    rust = { "rustfmt" },
    nix = { "nixpkgs_fmt" },
    gdscript = { "gdformat" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },

  format_on_save = {
    lsp_fallback = false,
    timeout_ms = 500,
  },

  log_level = vim.log.levels.OFF,
}

return M
