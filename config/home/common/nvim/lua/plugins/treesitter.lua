--- Syntax highlighting.

---@type PluginConfig
return {
  spec = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
  },

  opts = function()
    return {
      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = {
        enable = true,
      },
    }
  end,

  config = function(_, opts)
    require("utils").setup("nvim-treesitter.configs", opts)
  end,

  base46 = { "syntax", "treesitter" },
}
