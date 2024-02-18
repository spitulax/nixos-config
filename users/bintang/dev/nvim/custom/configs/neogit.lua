local M = {}

M.opts = {
  graph_style = "unicode",
  commit_select_view = {
    kind = "auto",
  },
  log_view = {
    kind = "auto",
  },
  reflog_view = {
    kind = "auto",
  },
  signs = {
    hunk = { "", "" },
    item = { "󰁔", "󱞣" },
    section = { "󰜴", "󱞤" },
  },
  integrations = {
    telescope = true,
    diffview = true,
  },
  mappings = {
    commit_editor = {
      ["<c-cr>"] = "Submit",
      ["<c-bs>"] = "Abort",
    },
    rebase_editor = {
      ["<c-cr>"] = "Submit",
      ["<c-bs>"] = "Abort",
    },
  },
}

M.mappings = {
  plugin = true,
  n = {
    ["<leader>g"] = { "<cmd>Neogit<cr>", "Open Neogit" },
  },
}

return M
