---@type PluginConfig
return {
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Notes",
          },
        },
      },
    },
  },

  mappings = {
    Neorg = {
      n = {
        {
          desc = "Toggle table of contents",
          lhs = "<M-g>O",
          rhs = "<cmd>Neorg toc<cr>",
        },
      },
    },
  },
}
