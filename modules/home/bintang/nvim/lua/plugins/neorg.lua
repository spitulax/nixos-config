--- Take notes with neovim.

---@type PluginConfig
return {
  spec = {
    "nvim-neorg/neorg",
    ft = "norg",
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        -- opts = {
        --   rocks = {
        --     hererocks = true,
        --   },
        -- },
      },
    },
    -- build = ":Neorg sync-parsers", -- neorg provides its own build script
    cmd = "Neorg",
  },

  opts = function()
    return {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Notes",
            },
          },
        },
      },
    }
  end,

  mappings = function()
    return {
      Neorg = {
        n = {
          {
            desc = "Toggle table of contents",
            lhs = "<M-g>O",
            rhs = "<cmd>Neorg toc<cr>",
          },
        },
      },
    }
  end,
}
