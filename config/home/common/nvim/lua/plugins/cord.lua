--- Discord RPC.

---@type PluginConfig
return {
  spec = {
    "vyfor/cord.nvim",
    lazy = false,
  },

  opts = function()
    return {
      display = {
        theme = "catppuccin",
        flavor = "accent",
      },
    }
  end,
}
