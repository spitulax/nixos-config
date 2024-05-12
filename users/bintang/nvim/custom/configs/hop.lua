local M = {}

M.opts = {
  multi_windows = true,
}

local mapping = {
  ["<C-m>"]      = { "<cmd>HopWord<cr>", "Hop word" },
  ["<C-m>m"] = { "<cmd>HopWord<cr>", "Hop word" },
  ["<C-m>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
  ["<C-m>C"]     = { "<cmd>HopChar2<cr>", "Hop two chars" },
  ["<C-m>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
  ["<C-m>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
  ["<C-m>L"]     = { "<cmd>HopLine<cr>", "Hop line" },
}

M.mappings = { n = mapping, v = mapping }

return M
