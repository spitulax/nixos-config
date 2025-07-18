--- Show copy register history with telescope.

---@type PluginConfig
return {
  spec = { "AckslD/nvim-neoclip.lua" },

  opts = function()
    return {
      default_register = { '"', "+", "*" },
      keys = {
        telescope = {
          i = {
            paste = "<c-v>",
          },
        },
      },
    }
  end,
}
