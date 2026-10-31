-- Cannot require nvchad.tabufline.utils due to cyclic dependency, since that file requires chadrc.
-- local txt = require("nvchad.tabufline.utils").txt
-- local btn = require("nvchad.tabufline.utils").btn

local txt = function(str, hl)
  str = str or ""
  local a = "%#Tb" .. hl .. "#" .. str
  return a
end

local btn = function(str, hl, func, arg)
  str = hl and txt(str, hl) or str
  arg = arg or ""
  return "%" .. arg .. "@Tb" .. func .. "@" .. str .. "%X"
end

local modules = {
  tablist = function()
    local result, tabs = "", vim.fn.tabpagenr("$")

    for nr = 1, tabs, 1 do
      local tab_hl = "TabO" .. (nr == vim.fn.tabpagenr() and "n" or "ff")
      result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
    end

    return result .. txt("%=", "Fill")
  end,

  bufname = function()
    local bufname = vim.api.nvim_buf_get_name(vim.fn.bufnr("%"))
    local name = ""
    if bufname:find(vim.fn.getcwd(), 1, true) ~= nil then
      name = vim.fn.fnamemodify(bufname, ":.")
    ---@diagnostic disable-next-line: undefined-field
    elseif bufname:find(vim.uv.os_homedir(), 1, true) ~= nil then
      name = vim.fn.fnamemodify(bufname, ":~")
    elseif bufname:sub(1, #"term://") == "term://" then
      name = "Terminal"
    else
      name = ""
    end
    name = (name:find("NvimTree", 1, true) ~= nil) and "NvimTree" or name
    return txt(name, "Bufname")
  end,
}

return {
  enabled = false,
  lazyload = false,
  order = { "tablist", "bufname" },
  modules = modules,
}
