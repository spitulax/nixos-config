local M = {}

M.opts = {
  default_mappings = false,
}

M.mappings = {
  n = {
    ["<leader>Co"] = { "<Plug>(git-conflict-ours)", "Choose ours" },
    ["<leader>Ct"] = { "<Plug>(git-conflict-theirs)", "Choose theirs" },
    ["<leader>Cb"] = { "<Plug>(git-conflict-both)", "Choose both" },
    ["<leader>C0"] = { "<Plug>(git-conflict-none)", "Choose none" },
    ["<leader>Cp"] = { "<Plug>(git-conflict-prev-conflict)", "Move to previous conflict" },
    ["<leader>Cn"] = { "<Plug>(git-conflict-next-conflict)", "Move to next conflict" },
  },
}

return M
