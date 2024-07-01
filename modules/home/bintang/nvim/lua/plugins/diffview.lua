--- Diff viewer.

---@type PluginConfig
return {
  spec = {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  mappings = function()
    return {
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
    }
  end,
}
