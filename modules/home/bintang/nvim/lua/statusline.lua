local utils = require("nvchad.stl.utils")

local modules = {
  file = function()
    local x = utils.file()
    local name = "  " .. x[2] .. " "
    local is_modified = vim.bo[utils.stbufnr()].modified
    return "  %#StText#" .. x[1] .. name .. (is_modified and "  " or "")
  end,
  cursor_position = function()
    return "%#StText# %l:%c (%P)  "
  end,
  filetype = function()
    local ft = vim.bo[utils.stbufnr()].ft
    return ft == "" and "plain text  " or ft .. "  "
  end,
  lsp_status = function()
    if rawget(vim, "lsp") and vim.version().minor >= 10 then
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.attached_buffers[utils.stbufnr()] then
          return client.name .. "  "
        end
      end
    end
    return ""
  end,
  cwd = function()
    local name = vim.uv.cwd()
    name = "%#st_mode# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
    return name
  end,
  diagnostics_enabled = function()
    return vim.diagnostic.is_enabled() and " 󰗠  " or ""
  end
}

return  {
  theme = "vscode",
  separator_style = "block",
  order = { "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "diagnostics_enabled", "cursor_position", "filetype", "lsp_status", "cwd" },
  modules = modules,
}
