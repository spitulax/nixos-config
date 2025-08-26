local M = {}

local utils = require("utils")

---@type table<string, LanguageConfig>
local configs = {}
for name, _ in vim.fs.dir(utils.language_config_path) do
  local ft = name:gsub(".lua", "", 1)
  local config = require("languages." .. ft)
  configs[ft] = config
end

---@param config LanguageConfig
---@param filename string
---@param callback fun(ft: string)
local function each_ft(config, filename, callback)
  for _, ft in ipairs(config.fts or { filename }) do
    callback(ft)
  end
end

---@param cond fun(config: LanguageConfig): boolean
---@param callback fun(config: LanguageConfig, ft: string)
local function each_config(cond, callback)
  for f, config in pairs(configs) do
    if cond(config) then
      each_ft(config, f, function(ft)
        callback(config, ft)
      end)
    end
  end
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
  each_config(function(config)
    return config.formatter ~= nil and config.formatter ~= "lsp"
  end, function(config, ft)
    formatters[ft] = { config.formatter }
  end)
  return formatters
end

---@return string[]
M.fts_format_with_lsp = function()
  local fts = {}
  each_config(function(config)
    return config.formatter == "lsp"
  end, function(_, ft)
    table.insert(fts, ft)
  end)
  return fts
end

M.autocmds = function()
  each_config(function(config)
    return config.autocmd ~= nil or config.indent ~= nil
  end, function(config, ft)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        if config.autocmd ~= nil then
          config.autocmd()
        end

        if config.indent ~= nil then
          utils.indent(config.indent)
        end
      end,
    })
  end)
end

return M
