return {
  config = function()
    require("leap").opts.prev_target = "<backspace>"
    require("leap").opts.prev_group = "<backspace>"
    require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
    require("leap.user").set_repeat_keys("<enter>", "<backspace>")
  end,
}
