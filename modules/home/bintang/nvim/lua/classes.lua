---@meta

---@class Mappings
---@field desc? string
---@field lhs string
---@field rhs string|function
---@field opts? vim.keymap.set.Opts

---@class MappingSection
---@field a? Mappings[] n, v, x
---@field n? Mappings[] normal
---@field i? Mappings[] insert
---@field v? Mappings[] visual
---@field x? Mappings[] select
---@field t? Mappings[] term

---@alias MappingTable table<string, MappingSection>

---@class PluginConfig
---@field opts? table
---@field config? fun(LazyPlugin?, opts?: table)
---@field mappings? MappingTable
