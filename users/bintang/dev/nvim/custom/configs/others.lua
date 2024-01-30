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

return M
