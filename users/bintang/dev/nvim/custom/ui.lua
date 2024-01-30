local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local function is_activewin()
  return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL (no)",
  ["nov"] = "NORMAL (nov)",
  ["noV"] = "NORMAL (noV)",
  ["noCTRL-V"] = "NORMAL",
  ["niI"] = "NORMAL i",
  ["niR"] = "NORMAL r",
  ["niV"] = "NORMAL v",
  ["nt"] = "NTERMINAL",
  ["ntT"] = "NTERMINAL (ntT)",

  ["v"] = "VISUAL",
  ["vs"] = "V-CHAR (Ctrl O)",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  [""] = "V-BLOCK",

  ["i"] = "INSERT",
  ["ic"] = "INSERT (completion)",
  ["ix"] = "INSERT completion",

  ["t"] = "TERMINAL",

  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE (Rc)",
  ["Rx"] = "REPLACEa (Rx)",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE (Rvc)",
  ["Rvx"] = "V-REPLACE (Rvx)",

  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  [""] = "S-BLOCK",
  ["c"] = "COMMAND",
  ["cv"] = "COMMAND",
  ["ce"] = "COMMAND",
  ["r"] = "PROMPT",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["x"] = "CONFIRM",
  ["!"] = "SHELL",
}

local statusline_modules = {
  mode = function()
    if not is_activewin() then
      return ""
    end

    local m = vim.api.nvim_get_mode().mode
    return "%#St_Mode#" .. string.format(" %s ", modes[m])
  end,

  modified = function()
    return "  "
  end,

  cursor_position = function()
    return vim.o.columns > 140 and "%#StText# %l,%c  " or ""
  end,

  filetype = function()
    local ft = vim.bo[stbufnr()].ft
    return ft == "" and "plain text  " or ft .. " "
  end,

  lsp_status = function()
    if rawget(vim, "lsp") then
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
          return (vim.o.columns > 100 and " " .. client.name .. " ") or "   "
        end
      end
      return ""
    end
  end,
}

local M = {}

M.statusline = {
  theme = "vscode",
  separator_style = "block",
  overriden_modules = function(modules)
    -- Mode
    modules[1] = statusline_modules.mode()
    -- Cursor Position
    modules[9] = statusline_modules.cursor_position()
    -- Filetype
    modules[11] = statusline_modules.filetype()
    -- LSP Status
    modules[12] = statusline_modules.lsp_status()
    -- Modified
    if vim.bo[stbufnr()].modified then
      table.insert(modules, 3, statusline_modules.modified())
    end
  end
}

return M
