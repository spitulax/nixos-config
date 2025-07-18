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
  for f, config in pairs(configs) do
    if config.formatter ~= nil and config.formatter ~= "lsp" then
      for _, ft in ipairs(config.extra_fts or { f }) do
        formatters[ft] = { config.formatter }
      end
    end
  end
  return formatters
end

---@return string[]
M.fts_format_with_lsp = function()
  local fts = {}
  for f, config in pairs(configs) do
    if config.formatter == "lsp" then
      for _, ft in ipairs(config.extra_fts or { f }) do
        table.insert(fts, ft)
      end
    end
  end
  return fts
end

M.autocmds = function()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(arg)
      for f, config in pairs(configs) do
        if config.indent ~= nil then
          for _, ft in ipairs(config.extra_fts or { f }) do
            if vim.bo[arg.buf].filetype == ft then
              utils.indent(config.indent)
              return
            end
          end
        end
      end
      utils.indent(vim.g.default_indent)
    end,
  })
end

return M
