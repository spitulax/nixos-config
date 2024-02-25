local M = {}

M.opts = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "-" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },
}

M.mappings = {
  plugin = true,
  n = {
    ["<leader>B"] = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
    ["<leader>tb"] = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
  }
}

return M
