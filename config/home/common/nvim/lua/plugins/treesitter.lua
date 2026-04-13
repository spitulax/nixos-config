--- Syntax highlighting.

---@type PluginConfig
return {
  spec = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUninstall", "TSUpdate" },
    build = ":TSUpdate",
  },

  opts = function()
    return {
      install_dir = vim.fn.stdpath("data") .. "/site",
    }
  end,

  config = function(_, opts)
    require("utils").setup("nvim-treesitter", opts)
  end,

  base46 = { "syntax", "treesitter" },
}
