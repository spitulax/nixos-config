local M = {}

M.opts = {
  is_insert_mode = true,
}

M.mappings = {
  n = {
    ["<leader>s"] = { "<cmd>Spectre<cr>", "Open Spectre" }, -- mini.surround key bindings only work in visual mode
  },
}

return M
