local M = {}

M.opts = {
  multi_windows = true,
}

M.mappings = {
  n = {
    ["<Tab>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<Tab><Tab>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<Tab>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
    ["<Tab>C"] = { "<cmd>HopChar2<cr>", "Hop two chars" },
    ["<Tab>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
    ["<Tab>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
    ["<Tab>L"] = { "<cmd>HopLine<cr>", "Hop line" },
  },
  v = {
    ["<Tab>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<Tab><Tab>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<Tab>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
    ["<Tab>C"] = { "<cmd>HopChar2<cr>", "Hop two chars" },
    ["<Tab>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
    ["<Tab>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
    ["<Tab>L"] = { "<cmd>HopLine<cr>", "Hop line" },
  },
}

return M
