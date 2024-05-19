-- https://github.com/NvChad/base46/blob/v2.0/lua/base46/themes/catppuccin.lua

local M = {}

---@type Base46HLGroupsList
M.override = {
  CursorLineNr = { bold = true },
  Visual = { reverse = true },
  NvimTreeRootFolder = { fg = "green" },
  Comment = { fg = "light_grey", italic = true },
  ["@comment"] = { link = "Comment" },
  Conditional = { bold = true },
  Keyword = { bold = true },
  Type = { bold = true },
  Typedef = { bold = true },
}

---@type Base46HLGroupsList
M.add = {
  NvimTreeModifiedFile = { fg = "orange" },
  CurSearch = { fg = "black", bg = "red" },
  IncSearch = { fg = "black", bg = "red" },
  Search = { fg = "black", bg = "yellow" },
  CursorLine = { bg = "one_bg" },
  GitSignsCurrentLineBlame = { link = "Comment" },

  NeogitDiffContext = { bg = "black2" },
  NeogitDiffContextCursor = { bg = "black2" },
  NeogitDiffContextHighlight = { bg = "black2" },
  NeogitDiffAdditions = { fg = "green" },
  NeogitDiffAdd = { fg = "green", bg = "one_bg" },
  NeogitDiffAddCursor = { fg = "green", bg = "one_bg" },
  NeogitDiffAddHighlight = { fg = "green", bg = "one_bg" },
  NeogitDiffDeletions = { fg = "red" },
  NeogitDiffDelete = { fg = "red", bg = "one_bg" },
  NeogitDiffDeleteCursor = { fg = "red", bg = "one_bg" },
  NeogitDiffDeleteHighlight = { fg = "red", bg = "one_bg" },
}

return M
