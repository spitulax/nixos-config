--- Many utilities in a single plugin.

---@type PluginConfig
return {
  spec = {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
  },

  config = function(_, _)
    require("mini.align").setup()
    require("mini.surround").setup({
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
