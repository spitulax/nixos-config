--- `f` that can accept 2 characters and jump to a different line.

---@type PluginConfig
return {
  spec = {
    "https://codeberg.org/andyg/leap.nvim",
    event = "User FilePost",
  },

  config = function(_, _)
    require("leap").opts.prev_target = "<backspace>"
    require("leap").opts.prev_group = "<backspace>"
    require("leap").opts.equivalence_classes =
      { " \t\r\n", "([{", ")]}", "'\"`" }
    require("leap.user").set_repeat_keys("<kPageUp>", "<kPageDown>")
  end,

  mappings = function()
    return {
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
    }
  end,
}
