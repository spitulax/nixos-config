--- Indicates changes about to be made by `:norm` and `:s`.

local utils = require("utils")

---@type PluginConfig
return {
  spec = {
    "smjonas/live-command.nvim",
    event = "User FilePost",
  },

  opts = function()
    return {
      commands = {
        Norm = { cmd = "norm" },
        Reg = {
          cmd = "norm",
          args = function(opts)
            return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
          end,
          range = "",
        },
      },
    }
  end,

  config = function(_, opts)
    utils.setup("live-command", opts) -- lazy.nvim default config function just does't work
  end,
}
