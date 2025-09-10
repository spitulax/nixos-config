local opt = vim.opt
local g = vim.g

--- Custom Options ---

g.default_indent = 4
g.disable_autoformat = false
g.global_multiplier = 10

----------------------

opt.laststatus = 3
opt.showmode = false
opt.splitkeep = "screen"
opt.listchars = {
  space = "·",
  tab = "<->",
  trail = "∼",
  nbsp = "-",
  extends = "→",
  precedes = "←",
}
opt.fillchars = { eob = " " }
opt.list = true
opt.wrap = false
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = g.default_indent
opt.tabstop = g.default_indent
opt.softtabstop = g.default_indent
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = false
opt.cursorline = true
opt.cursorlineopt = "number"
opt.clipboard = ""
opt.complete = ""
opt.timeoutlen = 500
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.sidescroll = 10
opt.ignorecase = true
opt.smartcase = true
opt.shortmess:append("sI")
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 250
opt.whichwrap:append("<>[]hl")

--- Global Plugin Options ---

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.c_syntax_for_h = 1
g.tmux_navigator_disable_when_zoomed = 1
g.tmux_navigator_no_mappings = 1

-----------------------------
