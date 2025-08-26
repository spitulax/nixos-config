--- Indentation guides.

---@type PluginConfig
return {
  spec = { "lukas-reineke/indent-blankline.nvim" },

  opts = function()
    return {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    }
  end,

  config = function(_, opts)
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    require("utils").setup("ibl", opts)
  end,

  base46 = "blankline",
}
