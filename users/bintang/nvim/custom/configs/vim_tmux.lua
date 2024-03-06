local M = {}

M.mappings = {
  n = {
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Window left" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Window up" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Window right" },
  },
}

return M
