local M = {}

M.mappings = {
  n = {
    ["<leader>i"] = { "<cmd>IconPickerYank<cr>", "Open icon picker" },
  },
  i = {
    ["<M-i>"] = { "<cmd>IconPickerInsert<cr>", "Insert an icon" },
  },
}

return M
