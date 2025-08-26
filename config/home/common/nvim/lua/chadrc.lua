---@type ChadrcConfig
local M = {}

local highlight = require("ui.highlight")

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  hl_override = highlight.override,
  hl_add = highlight.add,
}

M.ui = {
  cmp = {
    style = "default",
  },
  telescope = {
    style = "bordered",
  },
  statusline = require("ui.statusline"),
  tabufline = require("ui.tabufline"),
}

M.nvdash = {
  load_on_startup = false,
}

M.lsp = {
  signature = true,
}

M.colorify = {
  enabled = false,
}

return M
