--- Many utilities in a single plugin.

local utils = require("utils")

---@type PluginConfig
return {
  spec = {
    "echasnovski/mini.nvim",
    version = false,
    event = "User FilePost",
  },

  config = function(_, _)
    utils.setup("mini.align")
    utils.setup("mini.surround", {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    })
  end,
}
