local M = {}

local utils = require("utils")

---@type table<string, LanguageConfig>
local configs = {}
for name, _ in vim.fs.dir(utils.language_config_path) do
  local ft = name:gsub(".lua", "", 1)
  local config = require("languages." .. ft)
  configs[ft] = config
end

---@return table<string, table>
M.lsp_servers = function()
  local servers = {}
  for _, config in pairs(configs) do
    if config.lsp_name ~= nil then
      servers[config.lsp_name] = config.lsp_config or {}
    end
  end
  return servers
end

---@return table<string, string[]>
M.formatters_by_ft = function()
  local formatters = {}
  for ft, config in pairs(configs) do
    if config.formatter ~= nil then
      formatters[ft] = { config.formatter } or {}
    end
  end
  return formatters
end

M.autocmds = function()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(arg)
      for ft, config in pairs(configs) do
        if config.indent ~= nil and vim.bo[arg.buf].filetype == ft then
          utils.indent(config.indent)
          return
        end
      end
      utils.indent(vim.g.default_indent)
    end,
  })
end

return M
