local general_mapping = require("mappings")
local plugins = require("internals.plugins")
local utils = require("utils")

---@type MappingTable[]
local mappings = {}
table.insert(mappings, general_mapping)
for _, v in pairs(plugins.configs) do
  ---@type PluginConfig
  if vim.is_callable(v.mappings) then
    table.insert(mappings, v.mappings())
  end
end
utils.apply_mappings(mappings)
