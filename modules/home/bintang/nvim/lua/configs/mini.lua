---@type PluginConfig
return {
  config = function(_, _)
    require("mini.align").setup()
    require("mini.bufremove").setup()
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
