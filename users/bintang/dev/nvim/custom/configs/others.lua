local M = {}

M.gitsigns = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "-" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },
}

M.neoclip = {
  default_register = { '"', '+', '*' },
  keys = {
    telescope = {
      i = {
        paste = '<c-v>',
      },
    },
  },
}

M.blankline = {
  context_char = '┃',
}

M.git_conflict = {
  default_mappings = false,
}

M.hop = {
  multi_windows = true,
}

M.spectre = {
  is_insert_mode = true,
}

return M
