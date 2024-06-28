---@type PluginConfig
return {
  mappings = {
    Diffview = {
      n = {
        {
          desc = "Open Diffview",
          lhs = "fd",
          rhs = "<cmd>DiffviewOpen<cr>",
        },
        {
          desc = "Open file history",
          lhs = "fD",
          rhs = "<cmd>DiffviewFileHistory<cr>",
        },
      },
    },
  },
}
