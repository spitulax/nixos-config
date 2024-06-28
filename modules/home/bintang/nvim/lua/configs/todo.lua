---@type PluginConfig
return {
  mappings = {
    Todo = {
      n = {
        {
          desc = "Todo Jump to previous todo comment",
          lhs = "[t",
          rhs = require("todo-comments").jump_prev,
        },
        {
          desc = "Todo Jump to next todo comment",
          lhs = "]t",
          rhs = require("todo-comments").jump_next,
        },
        {
          desc = "Search all todo comments",
          lhs = "fq",
          rhs = require("todo-comments").jump_next,
        },
      },
    },
  },
}
