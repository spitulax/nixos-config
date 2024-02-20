local opt = vim.opt
local g = vim.g

opt.listchars = {
  space = "·",
  tab = "->",
  trail = "∼",
  nbsp = "-",
  extends = "→",
  precedes = "←",
}
opt.list = true

opt.wrap = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.clipboard = ""
opt.complete = ""
opt.timeoutlen = 500
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.sidescroll = 5

g.c_syntax_for_h  = 1

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("base46").load_all_highlights()
  end,
})
