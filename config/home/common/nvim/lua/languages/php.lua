---@type LanguageConfig
return {
  lsp_name = "intelephense",
  formatter = { "pint", "mago_format" },
  indent = 4,
  autocmd = function()
    -- Somehow something changes indentexpr to `GetPhpIndent()`
    vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
}
