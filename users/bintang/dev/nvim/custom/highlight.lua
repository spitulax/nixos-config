local M = {}

---@type Base46HLGroupsList
M.override = {
  -- Nvim
  CursorLine = { bg = "NONE" },
  CursorLineNr = { bold = true, fg = "white" },
  Visual = { bg = "one_bg2" },

  -- Nvim-tree
  NvimTreeRootFolder = { fg = "green" },

  -- Statusline
  St_Mode = { bg = "NONE" },

  -- Syntax highlighting
  Special = { fg = "nord_blue" },
  Boolean = { bold = true },
  Keyword = { bold = true },
  Type = { bold = true },
}

---@type Base46HLGroupsList
M.add = {
  -- Nvim
  TabLine = { underline = false, bg = "NONE", fg = "light_grey" },
  TabLineSel = { bold = true, bg = "NONE", fg = "blue" },
  TabLineFill = { bg = "NONE" },
  LineNr = { fg = "light_grey" },

  -- Syntax highlighting
  Comment = { fg = "light_grey", italic = true },

  -- Statusline
  NvimTreeModifiedFile = { fg = "orange" },
}

return M
