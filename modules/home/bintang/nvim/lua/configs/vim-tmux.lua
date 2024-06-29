---@type PluginConfig
return {
  mappings = {
    TmuxNavigation = {
      n = {
        {
          desc = "Window left",
          lhs = "<C-h>",
          rhs = "<cmd>TmuxNavigateLeft<cr>",
        },
        {
          desc = "Window down",
          lhs = "<C-j>",
          rhs = "<cmd>TmuxNavigateDown<cr>",
        },
        {
          desc = "Window up",
          lhs = "<C-k>",
          rhs = "<cmd>TmuxNavigateUp<cr>",
        },
        {
          desc = "Window right",
          lhs = "<C-l>",
          rhs = "<cmd>TmuxNavigateRight<cr>",
        },
      },
    },
  },
}
