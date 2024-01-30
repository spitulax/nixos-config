---@type ChadrcConfig
local M = {}

local highlight = require("custom.highlight")

M.plugins = "custom.plugins"

M.ui = {
  theme = "catppuccin",
  transparency = true,
  lsp_semantic_tokens = false,

  hl_override = highlight.override,
  hl_add = highlight.add,

  cmp = {
    selected_item_bg = "simple",
  },

  statusline = require("custom.ui").statusline,

  tabufline = {
    enabled = false,
    show_numbers = false,
    overriden_modules = function(modules)
      table.remove(modules, 4) -- remove tabufline buttons
    end,
  },

  nvdash = {
    load_on_startup = false,

    header = {
      "        Neovim v" .. (vim.version().major) .. "." .. (vim.version().minor) .. "." .. (vim.version().patch) .. "        ",
    },
  },
}

M.mappings = require("custom.mappings")

return M
