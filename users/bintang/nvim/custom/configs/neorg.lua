local M = {}

M.opts = {
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

M.mappings = {
  n = {
    ["<leader>N"] = { "<cmd>Neorg toc<cr>", "Toggle table of contents in norg files" },
  },
}

return M
