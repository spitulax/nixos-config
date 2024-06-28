---@type PluginConfig
return {
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "-" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
  },

  mappings = {
    Gitsigns = {
      a = {
        {
          desc = "Go to previous hunk",
          lhs = "<leader>[c",
          rhs = "<cmd>Gitsigns prev_hunk<cr>",
        },
        {
          desc = "Go to next hunk",
          lhs = "<leader>]c",
          rhs = "<cmd>Gitsigns next_hunk<cr>",
        },
      },
      n = {
        {
          desc = "Blame line",
          lhs = "<leader>B",
          rhs = "<cmd>Gitsigns blame_line<cr>",
        },
        {
          desc = "Toggle current line blame",
          lhs = "<leader>tb",
          rhs = "<cmd>Gitsigns toggle_current_line_blame<cr>",
        },
      },
    },
  },
}
