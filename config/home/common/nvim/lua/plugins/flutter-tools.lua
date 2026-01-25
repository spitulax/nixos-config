--- Flutter stuff.

---@type PluginConfig
return {
  spec = {
    "nvim-flutter/flutter-tools.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "rcarriga/nvim-dap-ui",
    },
    ft = "dart",
  },

  config = function(_, opts)
    require("utils").setup("flutter-tools", opts)
    require("telescope").load_extension("flutter")
  end,

  opts = function()
    return {
      ui = {
        border = "single",
      },
      debugger = {
        enabled = true,
      },
      dev_log = {
        enabled = false,
      },
    }
  end,

  mappings = function()
    return {
      Flutter = {
        n = {
          {
            desc = "Telescope",
            lhs = "<leader>fF",
            rhs = require("telescope").extensions.flutter.commands,
          },
        },
      },
    }
  end,
}
