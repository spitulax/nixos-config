--- Laravel stuff.

---@type PluginConfig
return {
  spec = {
    "adalessa/laravel.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    ft = { "php", "blade" },
    event = { "BufEnter composer.json" },
  },

  opts = function()
    return {
      features = {
        pickers = {
          provider = "telescope",
        },
      },
    }
  end,

  mappings = function()
    return {
      Laravel = {
        n = {
          {
            desc = "Open Laravel Picker",
            lhs = "<leader>fL",
            rhs = function()
              Laravel.pickers.laravel()
            end,
          },
        },
      },
    }
  end,
}
