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
    return vim.o.columns > 140 and "%#StText# %l:%c:%P  " or ""
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

local tabufline_modules = {
  tablist = function()
    local result, number_of_tabs = "", vim.fn.tabpagenr "$"

    for i = 1, number_of_tabs, 1 do
      local tab_hl = ((i == vim.fn.tabpagenr()) and "%#TbLineTabOn# ") or "%#TbLineTabOff# "
      result = result .. ("%" .. i .. "@TbGotoTab@" .. tab_hl .. i .. " ")
    end

    return result .. "%#TblineFill#" .. "%="
  end,

  bufname = function()
    local bufname = vim.api.nvim_buf_get_name(vim.fn.bufnr("%"))
    local name
    if bufname:find(vim.fn.getcwd(), 1, true) ~= nil then
      name = vim.fn.fnamemodify(bufname, ":.")
    elseif bufname:find(vim.loop.os_homedir(), 1, true) ~= nil then
      name = vim.fn.fnamemodify(bufname, ":~")
    elseif bufname:sub(1, #("term://")) == "term://" then
      name = "Terminal"
    else
      name = ""
    end
    name = (name:find("NvimTree", 1, true) ~= nil) and "NvimTree" or name
    name = "%#StatusLine#" .. name
    return name
  end,

  clock = function()
    local time = os.date("%H:%M:%S")
    return "%#StatusLine#" .. "  " .. time
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

M.tabufline = {
  enabled = true,
  lazyload = false,
  show_numbers = false,
  overriden_modules = function(modules)
    modules[5] = tabufline_modules.clock()
    modules[4] = tabufline_modules.bufname()
    modules[3] = tabufline_modules.tablist()
    table.remove(modules, 2) -- remove buffer list
  end,
}

return M
