--- Icon picker.

---@type PluginConfig
return {
  spec = {
    "ziontee113/icon-picker.nvim",
    cmd = { "IconPickerYank", "IconPickerInsert" },
    -- opts = require("plugins.icon-pick").opts,
    -- config = function(_, opts)
    --   require("icon-picker").setup(opts)
    -- end,
  },

  opts = function()
    return {
      disable_legacy_commands = true,
    }
  end,

  mappings = function()
    return {
      IconPicker = {
        n = {
          {
            desc = "Open icon picker",
            lhs = "<leader>i",
            rhs = "<cmd>IconPickerYank<cr>",
          },
        },
        i = {
          {
            desc = "Insert icon",
            lhs = "<M-i>",
            rhs = "<cmd>IconPickerInsert<cr>",
          },
        },
      },
    }
  end,
}
