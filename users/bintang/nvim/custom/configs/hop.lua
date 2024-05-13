local M = {}

M.opts = {
  multi_windows = true,
}

local mapping = {
  ["<C-f>f"] = { "<cmd>HopWord<cr>", "Hop word" },
  ["<C-f>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
  ["<C-f>C"] = { "<cmd>HopChar2<cr>", "Hop two chars" },
  ["<C-f>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
  ["<C-f>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
  ["<C-f>L"] = { "<cmd>HopLine<cr>", "Hop line" },
}

M.mappings = { n = mapping, v = mapping }

return M
