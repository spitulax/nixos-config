---@type LanguageConfig
return {
  lsp_name = "intelephense",
  formatter = "mago_format",
  -- formatter = "lsp",
  indent = 4,
  autocmd = function()
    -- Somehow something changes indentexpr to `GetPhpIndent()`
    vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
}
