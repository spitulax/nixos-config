---@type PluginConfig
return {
  config = function(_, _)
    require("leap").opts.prev_target = "<backspace>"
    require("leap").opts.prev_group = "<backspace>"
    require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
    require("leap.user").set_repeat_keys("<kPageUp>", "<kPageDown>")
  end,

  mappings = {
    Leap = {
      a = {
        {
          desc = "Forward",
          lhs = "s",
          rhs = "<Plug>(leap-forward)",
          opts = { remap = true },
        },
        {
          desc = "Backward",
          lhs = "S",
          rhs = "<Plug>(leap-backward)",
          opts = { remap = true },
        },
        {
          desc = "From window",
          lhs = "zs",
          rhs = "<Plug>(leap-from-window)",
          opts = { remap = true },
        },
      },
    },
  },
}
