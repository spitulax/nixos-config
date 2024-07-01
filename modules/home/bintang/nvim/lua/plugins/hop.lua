--- Jump to everywhere quickly.

---@type PluginConfig
return {
  spec = {
    "smoka7/hop.nvim",
    event = "User FilePost",
  },

  opts = function()
    return {
      multi_windows = true,
    }
  end,

  mappings = function()
    return {
      Hop = {
        a = {
          {
            desc = "Word",
            lhs = "<C-f>",
            rhs = "<cmd>HopWord<cr>",
            opts = { remap = true },
          },
          {
            desc = "Word",
            lhs = "<C-f>f",
            rhs = "<cmd>HopWord<cr>",
          },
          {
            desc = "One char",
            lhs = "<C-f>c",
            rhs = "<cmd>HopChar1<cr>",
          },
          {
            desc = "Two chars",
            lhs = "<C-f>C",
            rhs = "<cmd>HopChar2<cr>",
          },
          {
            desc = "Search pattern",
            lhs = "<C-f>/",
            rhs = "<cmd>HopPattern<cr>",
          },
          {
            desc = "Line start",
            lhs = "<C-f>l",
            rhs = "<cmd>HopLineStart<cr>",
          },
          {
            desc = "Line",
            lhs = "<C-f>L",
            rhs = "<cmd>HopLine<cr>",
          },
        },
      },
    }
  end,
}
