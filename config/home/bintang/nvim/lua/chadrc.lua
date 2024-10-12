---@type ChadrcConfig
local M = {}

local highlight = require("ui.highlight")

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  hl_override = highlight.override,
  hl_add = highlight.add,

  integrations = {
    "hop",
    "todo",
    "dap",
    "trouble",
  },
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
  load_on_startup = true,

  header = {
    "                            ",
    "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    "   ▄▀███▄     ▄██ █████▀    ",
    "   ██▄▀███▄   ███           ",
    "   ███  ▀███▄ ███           ",
    "   ███    ▀██ ███           ",
    "   ███      ▀ ███           ",
    "   ▀██ █████▄▀█▀▄██████▄    ",
    "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    "                            ",
    "        Neovim v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "        ",
    "",
  },

  buttons = {
    { txt = "  Find File", keys = "Spc o", cmd = "Telescope find_files" },
    { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
    { txt = "󰙅  Toggle File Explorer", keys = "Spc e", cmd = "NvimTreeToggle" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
    { txt = "󰗼  Exit Neovim", keys = "Spc Q", cmd = ":qa" },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },
    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}

M.lsp = {
  signature = true,
}

M.colorify = {
  mode = "bg",
}

return M
