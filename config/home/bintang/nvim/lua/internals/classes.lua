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
---@field spec LazyPluginSpec -- `opts` or `config` must not be specified here
---@field opts? fun(): table
---@field config? fun(self: LazyPlugin, opts: table)
---@field mappings? fun(): MappingTable
---@field disable? boolean
--- NOTE: `opts` and `mappings` must be functions if they call `require` to a plugin module, because the `PluginConfig` is first evaluated before loading the plugin

---@class LanguageConfig
---@field lsp_name? string    -- require("lspconfig").<lsp_name>.setup(<lsp_config>)
---@field lsp_config? table
---@field formatter? string   -- formatter from conform.nvim
---@field autocmd? fun()      -- TODO: autocmd: unimplemented
---@field indent? number
