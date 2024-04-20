---@type ChadrcConfig
local M = {}

local highlight = require("custom.highlight")

M.plugins = "custom.plugins"

M.ui = {
  theme = "catppuccin",
  transparency = true,
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
    load_on_startup = true,

    header = {
      "        Neovim v" .. (vim.version().major) .. "." .. (vim.version().minor) .. "." .. (vim.version().patch) .. "        ",
    },

    buttons = {
      { "  Find File", "Spc o", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "󰙅  Toggle NvimTree", "Spc e", "NvimTreeToggle" },
      { "󰗼  Exit Neovim", "Spc Q", ":qa" },
    },
  },
}

M.mappings = require("custom.mappings")

return M
