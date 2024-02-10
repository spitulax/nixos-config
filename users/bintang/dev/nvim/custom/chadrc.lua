---@type ChadrcConfig
local M = {}

local highlight = require("custom.highlight")

M.plugins = "custom.plugins"

M.ui = {
  theme = "catppuccin",
  transparency = false,
  lsp_semantic_tokens = true,

  hl_override = highlight.override,
  hl_add = highlight.add,
  extended_integrations = { "hop", "todo", "dap", "trouble" },

  cmp = {
    selected_item_bg = "simple",
  },

  telescope = { style = "bordered" },

  statusline = require("custom.ui").statusline,

  tabufline = require("custom.ui").tabufline,

  nvdash = {
    load_on_startup = false,

    header = {
      "        Neovim v" .. (vim.version().major) .. "." .. (vim.version().minor) .. "." .. (vim.version().patch) .. "        ",
    },
  },
}

M.mappings = require("custom.mappings")

return M
