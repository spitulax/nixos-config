---@type PluginConfig
return {
  spec = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = function()
    return {
      override = require("nvchad.icons.devicons"),
    }
  end,

  base46 = "devicons",
}
