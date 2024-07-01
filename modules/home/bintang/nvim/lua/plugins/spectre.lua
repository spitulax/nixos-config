--- Interactive `sed`

---@type PluginConfig
return {
  spec = {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
  },

  opts = function()
    return {
      is_insert_mode = true,
    }
  end,

  mappings = function()
    return {
      Spectre = {
        n = {
          {
            desc = "Open Spectre",
            lhs = "<leader>sp",
            rhs = "<cmd>Spectre<cr>",
          },
        },
      },
    }
  end,
}
