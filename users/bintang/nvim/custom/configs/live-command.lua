local M = {}

M.opts = {
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

return M
