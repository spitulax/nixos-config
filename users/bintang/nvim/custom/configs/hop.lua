local M = {}

M.opts = {
  multi_windows = true,
}

M.mappings = {
  n = {
    ["<leader><Space>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<leader><Space><Space>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<leader><Space>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
    ["<leader><Space>C"] = { "<cmd>HopChar2<cr>", "Hop two chars" },
    ["<leader><Space>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
    ["<leader><Space>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
    ["<leader><Space>L"] = { "<cmd>HopLine<cr>", "Hop line" },
  },
  v = {
    ["<leader><Space>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<leader><Space><Space>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<leader><Space>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
    ["<leader><Space>C"] = { "<cmd>HopChar2<cr>", "Hop two chars" },
    ["<leader><Space>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
    ["<leader><Space>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
    ["<leader><Space>L"] = { "<cmd>HopLine<cr>", "Hop line" },
  },
}

return M
