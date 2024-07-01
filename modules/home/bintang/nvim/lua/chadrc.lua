---@type ChadrcConfig
local M = {}

local highlight = require("ui.highlight")

M.ui = {
  theme = "catppuccin",
  transparency = true,
  hl_override = highlight.override,
  hl_add = highlight.add,

  cmp = {
    style = "default",
  },

  telescope = {
    style = "bordered",
  },

  statusline = require("ui.statusline"),

  tabufline = require("ui.tabufline"),

  nvdash = {
    load_on_startup = true,

    header = {
      "        Neovim v"
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "        ",
    },

    buttons = {
      { "  Find File", "Spc o", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "󰙅  Toggle NvimTree", "Spc e", "NvimTreeToggle" },
      { "󰗼  Exit Neovim", "Spc Q", ":qa" },
    },
  },

  lsp = {
    signature = true,
  },

  term = {
    hl = "Normal:term,WinSeparator:WinSeparator",
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },
}

M.base46 = {
  integrations = {
    "hop",
    "todo",
    "dap",
    "trouble",
  },
}

return M
