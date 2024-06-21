local function indent(n)
  vim.opt.shiftwidth = n
  vim.opt.tabstop = n
  vim.opt.softtabstop = n
end

local indent_four_fts = {
  "c",
  "cpp",
  "rust",
  "sh",
  "odin",
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(arg)
    for _, ft in ipairs(indent_four_fts) do
      if vim.bo[arg.buf].filetype == ft then
        indent(4)
        break
      end
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("base46").load_all_highlights()
  end,
})
