local M = {}

---@type Base46HLGroupsList
M.override = {
  CursorLineNr = { bold = true },
  Visual = { reverse = true },
  NvimTreeRootFolder = { fg = "green" },
  Comment = { fg = "light_grey", italic = true },
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
}

return M
