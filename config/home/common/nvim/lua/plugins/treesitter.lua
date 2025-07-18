--- Syntax highlighting.

---@type PluginConfig
return {
  spec = { "nvim-treesitter/nvim-treesitter" },

  opts = function()
    return {
      ensure_installed = { "all" },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = {
        enable = true,
      },
    }
  end,
}
