--- Snippets.

---@type PluginConfig
return {
  spec = {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
  },

  opts = function()
    return {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }
  end,

  config = function(_, opts)
    require("utils").setup("luasnip", opts)

    require("luasnip.loaders.from_vscode").lazy_load({
      exclude = vim.g.vscode_snippets_exclude or {},
    })
    require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

    require("luasnip.loaders.from_snipmate").load()
    require("luasnip.loaders.from_snipmate").lazy_load({
      paths = vim.g.snipmate_snippets_path or "",
    })

    require("luasnip.loaders.from_lua").load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

    require("luasnip").filetype_extend("php", { "html" })
  end,
}
