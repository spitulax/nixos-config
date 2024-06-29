---@type PluginConfig
return {
  opts = {
    indent = {
      char = "│",
      highlight = "IblChar",
    },
    scope = {
      char = "┃",
      highlight = "IblScopeChar",
      show_start = false,
      show_end = false,
    },
  },

  mappings = {
    Blankline = {
      a = {
        {
          desc = "Jump to current context",
          lhs = "<leader>cc",
          rhs = function()
            local config = { scope = {} }
            config.scope.exclude = { language = {}, node_type = {} }
            config.scope.include = { node_type = {} }
            local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

            if node then
              local start_row, _, end_row, _ = node:range()
              if start_row ~= end_row then
                vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
                vim.api.nvim_feedkeys("_", "n", true)
              end
            end
          end,
        },
      },
    },
  },
}
