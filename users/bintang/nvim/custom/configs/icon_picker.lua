local M = {}

M.mappings = {
  plugin = true,
  n = {
    ["<leader>i"] = { "<cmd>IconPickerYank<cr>", "Open icon picker" },
  },
  i = {
    ["<C-a>"] = { "<cmd>IconPickerInsert<cr>", "Insert an icon" },
  },
}

return M
