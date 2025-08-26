--- Automatically pairs brackets, e.g. '()', '{}', '[]'.

---@type PluginConfig
return {
  spec = { "windwp/nvim-autopairs" },

  opts = function()
    return {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    }
  end,

  config = function(_, opts)
    require("utils").setup("nvim-autopairs", opts)

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
