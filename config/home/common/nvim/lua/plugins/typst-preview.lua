--- Typst live preview.

---@type PluginConfig
return {
  spec = {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
  },

  opts = function()
    return {
      dependencies_bin = {
        ["tinymist"] = "tinymist",
        ["websocat"] = "websocat",
      },
    }
  end,
}
