return {
  opts = function()
    return {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
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
}
