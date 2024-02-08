local opt = vim.opt
local g = vim.g

opt.listchars = {
  space = "·",
  tab = "<->",
  trail = "∼",
  nbsp = "-",
}
opt.list = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.clipboard = ""
opt.complete = ""
opt.timeoutlen = 500

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- @TODO: use better tabline
vim.api.nvim_exec([[
  function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufn = bufname(buflist[winnr - 1])
    if bufn == ''
      return '[Empty]'
    else
      return fnamemodify(bufn, ":~:.")
    endif
  endfunction

  function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
      " select the highlighting
      if i + 1 == tabpagenr()
        let s ..= '%#TabLineSel#'
      else
        let s ..= '%#TabLine#'
      endif

      " set the tab page number (for mouse clicks)
      let s ..= '%' .. (i + 1) .. 'T'

      " the label is made by MyTabLabel()
      let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
      let s ..= '%=%#TabLine#%999X'
    endif

    return s
  endfunction

  set tabline=%!MyTabLine()
]], false)
