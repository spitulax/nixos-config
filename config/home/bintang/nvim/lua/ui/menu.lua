local M = {}

M.lsp = {
  {
    name = "Goto Definition",
    cmd = "Telescope lsp_definitions",
    rtxt = "gd",
  },

  {
    name = "Goto Type Definition",
    cmd = "Telescope lsp_type_definitions",
    rtxt = "gD",
  },

  {
    name = "Goto Implementation",
    cmd = "Telescope lsp_implementations",
    rtxt = "gi",
  },

  { name = "separator" },

  {
    name = "Show References",
    cmd = "Telescope lsp_references",
    rtxt = "gr",
  },

  {
    name = "Show Incoming Calls",
    cmd = "Telescope lsp_incoming_calls",
    rtxt = "gI",
  },

  {
    name = "Show Outgoing Calls",
    cmd = "Telescope lsp_outgoing_calls",
    rtxt = "gO",
  },

  {
    name = "Show document symbols",
    cmd = "Telescope lsp_document_symbols",
    rtxt = "<leader>ls",
  },

  {
    name = "Show workspace symbols",
    cmd = "Telescope lsp_workspace_symbols",
    rtxt = "<leader>lx",
  },

  {
    name = "Show dynamic workspace symbols",
    cmd = "Telescope lsp_implementations",
    rtxt = "<leader>lX",
  },

  {
    name = "Show diagnostics",
    cmd = "Telescope diagnostics",
    rtxt = "<leader>da",
  },

  {
    name = "Show signature help",
    cmd = vim.lsp.buf.signature_help,
    rtxt = "<leader>sh",
  },

  { name = "separator" },

  {
    name = "Add workspace folder",
    cmd = vim.lsp.buf.add_workspace_folder,
    rtxt = "<leader>wa",
  },

  {
    name = "Remove workspace folder",
    cmd = vim.lsp.buf.remove_workspace_folder,
    rtxt = "<leader>wr",
  },

  {
    name = "List workspace folders",
    cmd = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    rtxt = "<leader>lf",
  },

  { name = "separator" },

  {
    name = "NvRenamer",
    cmd = require("nvchad.lsp.renamer"),
    rtxt = "<leader>ra",
  },

  {
    name = "Diagnostic loclist",
    cmd = vim.diagnostic.setloclist,
    rtxt = "<leader>dq",
  },
}

M.telescope = {
  {
    name = "Find Keybindings",
    cmd = "Telescope keymaps",
    rtxt = "<leader>fk",
  },

  {
    name = "Find Color Highlights",
    cmd = "Telescope highlights",
    rtxt = "<leader>fc",
  },

  {
    name = "Find Help Page",
    cmd = "Telescope help_tags",
    rtxt = "<leader>fh",
  },
}

M.default = {
  {
    name = " LSP Actions",
    hl = "Exblue",
    items = M.lsp,
  },

  {
    name = "󰭎 Telescope Actions",
    hl = "Exblue",
    items = M.telescope,
  },

  { name = "separator" },

  {
    name = "Toggle nvim-tree",
    cmd = "NvimTreeToggle",
    rtxt = "<leader>e",
  },

  {
    name = "Open Icon Picker",
    cmd = "IconPickerYank",
    rtxt = "<leader>i",
  },

  {
    name = "Open Color Picker",
    cmd = function()
      require("minty.huefy").open()
    end,
    rtxt = "<leader>cp",
  },

  {
    name = "Open Shades Picker",
    cmd = function()
      require("minty.shades").open()
    end,
    rtxt = "<leader>cs",
  },

  {
    name = "Open Spectre",
    cmd = "Spectre",
    rtxt = "<leader>sp",
  },

  { name = "separator" },

  {
    name = "Format Buffer",
    cmd = function()
      require("conform").format({ lsp_fallback = true })
    end,
    rtxt = "<leader>fm",
  },

  { name = "separator" },

  {
    name = "󰉼 Toggle Autoformat",
    cmd = function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.cmd("redrawstatus")
    end,
    rtxt = "<leader>tf",
  },

  {
    name = "󰩂 Toggle Diagnostic",
    cmd = function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      vim.cmd("redrawstatus")
    end,
    rtxt = "<leader>td",
  },
}

return M
