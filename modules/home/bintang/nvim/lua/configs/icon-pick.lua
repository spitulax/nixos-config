---@type PluginConfig
return {
  opts = {
    disable_legacy_commands = true,
  },

  mappings = {
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
  },
}
