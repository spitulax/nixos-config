---@type PluginConfig
return {
  opts = {
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
        ["<m-cr>"] = "Submit",
        ["<m-bs>"] = "Abort",
      },
      rebase_editor = {
        ["<m-cr>"] = "Submit",
        ["<m-bs>"] = "Abort",
      },
    },
  },

  mappings = {
    Neogit = {
      n = {
        {
          desc = "Open Neogit",
          lhs = "<leader>G",
          rhs = "<cmd>Neogit<cr>",
        },
      },
    },
  },
}
