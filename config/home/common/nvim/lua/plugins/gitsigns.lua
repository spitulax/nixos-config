--- Git integration inside file. E.g. signcolumn indicating file changes, line blame, etc.

---@type PluginConfig
return {
  spec = {
    "lewis6991/gitsigns.nvim",
    lazy = false,
  },

  opts = function()
    return {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
    }
  end,

  mappings = function()
    return {
      Gitsigns = {
        a = {
          {
            desc = "Go to previous hunk",
            lhs = "[c",
            rhs = "<cmd>Gitsigns prev_hunk<cr>",
          },
          {
            desc = "Go to next hunk",
            lhs = "]c",
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
    }
  end,
}
