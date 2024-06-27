local map = vim.keymap.set
local unmap = vim.keymap.del
local utils = require("utils")
local mapn = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end
local mapa = function(lhs, rhs, opts)
  vim.keymap.set({ "n", "v", "x" }, lhs, rhs, opts)
end
local mapi = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

-- General
mapn("<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
mapn("<C-s>", "<cmd>w<CR>", { desc = "General Save file" })
mapn("<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "General Toggle nvcheatsheet" })
mapa("!", ":!", { desc = "General Enter shell command mode", nowait = true })
mapn("<leader>rt", require("base46").load_all_highlights, { desc = "General Reload highlights" })
mapa("<leader>Q", "<cmd>qa<cr>", { desc = "General Close Neovim" })
mapa("<C-n>", ":norm ", { desc = "General Execute normal mode commands", nowait = true })

-- Navigation
mapa(
  "j",
  'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
  { desc = "Navigation Move down", expr = true }
)
mapa(
  "k",
  'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
  { desc = "Navigation Move up", expr = true }
)
mapa("(", "zh", { desc = "Navigation Scroll left" })
mapa(")", "zl", { desc = "Navigation Scroll right" })
mapa("<M-m>", "<C-y>", { desc = "Navigation Scroll down" })
mapa("<M-n>", "<C-e>", { desc = "Navigation Scroll up" })
mapa("H", "zH", { desc = "Navigation Half screen to left" })
mapa("L", "zL", { desc = "Navigation Half screen to right" })
mapa("<M-<>", "gg", { desc = "Navigation Move to beginning of buffer" })
mapa("<M->>", "G", { desc = "Navigation Move to end of buffer" })
mapa("gt", "<C-]>", { desc = "Navigation Jump to tag definition under cursor" })
mapa("<M-g>t", "<C-W>]", { desc = "Navigation Jump to tag definition under (split window)" })

-- Terminal
map(
  "t",
  "<C-\\>",
  "<C-\\><C-n>",
  { desc = "Terminal Leave terminal mode", silent = true, nowait = true }
)
map(
  "t",
  "<C-d>",
  "<C-\\><C-n><C-w>q",
  { desc = "Terminal Close terminal", silent = true, nowait = true }
)

-- Clipboard
mapa("<C-p>", '"+p', { desc = "Clipboard Paste (p)" })
mapa("<M-p>", '"+P', { desc = "Clipboard Paste (P)" })
mapa("<C-y>", '"+y', { desc = "Clipboard Yank" })

-- Evil mode (yikes)
mapi("<C-b>", "<Left>", { desc = "Evil Move left" })
mapi("<C-f>", "<Right>", { desc = "Evil Move right" })
mapi("<C-n>", "<Down>", { desc = "Evil Move down" })
mapi("<C-p>", "<Up>", { desc = "Evil Move up" })
mapi("<C-h>", "<BS>", { desc = "Evil Backspace" })
mapi("<C-d>", "<kDel>", { desc = "Evil Delete" })
mapi("<M-d>", "<Esc>ldei", { desc = "Evil Delete next word" })
mapi("<C-k>", "<Esc>lDa", { desc = "Evil Delete from cursor to end of line" })
mapi("<C-a>", "<Esc>^i", { desc = "Evil Go to start of the line" })
mapi("<C-e>", "<End>", { desc = "Evil Go to end of the line" })
mapi("<M-b>", "<Esc>bi", { desc = "Evil Go to previous word" })
mapi("<M-f>", "<Esc>lea", { desc = "Evil Go to next word" })

-- Buffer management
mapn("<M-.>", "<cmd>bn<cr>", { desc = "Buffer Go to next buffer" })
mapn("<M-,>", "<cmd>bp<cr>", { desc = "Buffer Go to previous buffer" })
mapn("<leader>x", function()
  MiniBufremove.delete(0)
end, { desc = "Buffer Close current buffer" })
mapn("<leader>X", function()
  MiniBufremove.delete(vim.fn.bufnr("#"))
end, { desc = "Buffer Close previous buffer" })
mapn("<leader>bo", function()
  for i = 1, vim.fn.bufnr("$") do
    if vim.fn.bufexists(i) == 1 and i ~= vim.fn.bufnr("%") then
      MiniBufremove.delete(i)
    end
  end
end, { desc = "Buffer Close all other buffers" })
mapn("<leader>bx", function()
  for i = 1, vim.fn.bufnr("$") do
    if vim.fn.bufexists(i) == 1 then
      MiniBufremove.delete(i)
    end
  end
end, { desc = "Buffer Close all buffers" })
mapn("<leader>S", function()
  local buf = vim.api.nvim_create_buf(true, true)
  if buf ~= 0 then
    vim.api.nvim_set_current_buf(buf)
  end
end, { desc = "Buffer Create a scratch buffer " })

-- Window and tab management
mapn("<M-w>", "<C-w>|", { desc = "Window Max out window width" })
mapn("<M-u>", "<C-w>_", { desc = "Window Max out window height" })
mapn("<C-c>", "<C-w>q", { desc = "Window Close current window" })
mapn("<M-c>", "<C-w>o", { desc = "Window Close all other windows" })
mapn("<M-=>", "<C-w>+", { desc = "Window Increase window height" })
mapn("<M-->", "<C-w>-", { desc = "Window Decrease window height" })
mapn("<M-]>", "<C-w>>", { desc = "Window Increase window width" })
mapn("<M-[>", "<C-w><", { desc = "Window Decrease window width" })
mapn("<M-e>", "<C-w>=", { desc = "Window Uniform window size" })
mapn("<M-o>", "<C-w>p", { desc = "Window Go to previous window" })
mapn("<M-t>", "<cmd>tabnew<cr>", { desc = "Tab Create new tab" })
mapn("<M-q>", "<cmd>tabclose<cr>", { desc = "Tab Close current tab" })
mapn("<M-a>", "<cmd>tabonly<cr>", { desc = "Tab Close all other tabs" })
mapn("<M-f>", "gt", { desc = "Tab Go to next tab" })
mapn("<M-b>", "gT", { desc = "Tab Go to previous tab" })

-- Shortcuts
mapn("<leader>y", function()
  local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.fn.bufnr("%")), ":.")
  vim.fn.setreg("+", fname)
end, { desc = "Shortcuts Copy current file path" })
mapn("<leader>Y", function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.fn.bufnr("%")), ":.")
  vim.fn.setreg("+", fname .. ":" .. line)
end, { desc = "Shortcuts Copy current file path and line position" })
mapn("<leader>/", "gcc", { desc = "Shortcuts Toggle comment line", remap = true })
map("v", "<leader>/", "gc", { desc = "Shortcuts Toggle comment", remap = true })

-- Toggles
mapn("<leader>tw", function()
  vim.o.wrap = not vim.o.wrap
end, { desc = "Toggle Line wrap" })

-- LSP
mapn("<leader>dq", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })
mapn("<leader>dt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "LSP Toggle diagnostic" })
mapn("<M-d>", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "LSP Floating diagnostic" })
mapn("<leader>[d", function()
  vim.diagnostic.goto_prev({ float = { border = "rounded" } })
end, { desc = "LSP Previous diagnostic" })
mapn("<leader>]d", function()
  vim.diagnostic.goto_next({ float = { border = "rounded" } })
end, { desc = "LSP Next diagnostic" })

-- Neorg
mapn("<M-g>O", "<cmd>Neorg toc<cr>", { desc = "Neorg Toggle table of contents" })

-- Nvimtree
mapn("<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle nvimtree", nowait = true })
mapn("<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus nvimtree", nowait = true })

-- Gitsigns
mapn("<leader>B", "<cmd>Gitsigns blame_line<CR>", { desc = "Gitsigns Blame line" })
mapn(
  "<leader>tb",
  "<cmd>Gitsigns toggle_current_line_blame<CR>",
  { desc = "Gitsigns Toggle current line blame" }
)
mapa("[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Gitsigns Go to previous hunk" })
mapa("]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "Gitsigns Go to next hunk" })

-- Telescope
mapn("<leader>ff", "<cmd>Telescope resume <CR>", { desc = "Telescope Resume" })
mapn("<leader>fe", function()
  utils.prompt_callback("Find files in", "file", function(input)
    vim.cmd("Telescope find_files cwd=" .. input)
  end)
end, { desc = "Telescope Find files in specified directory" })
mapn("<leader>o", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
mapn("<C-b>", "<cmd>Telescope buffers<cr>", { desc = "Telescope Find buffers" })
mapn("<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope Find keybindings" })
mapn("<leader>ft", "<cmd>Telescope builtin<cr>", { desc = "Telescope Builtin commands" })
mapn("<leader>fc", "<cmd>Telescope highlights<cr>", { desc = "Telescope Color highlights" })
mapn("<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope Git commits" })
mapn("<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope Git branches" })
mapn("<leader>gs", "<cmd>Telescope git_stash<cr>", { desc = "Telescope Git stash" })
mapn("<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
mapn(
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  { desc = "Telescope Find in current buffer" }
)
mapn("<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
mapn("<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })
mapn("<leader>tt", "<cmd>Telescope themes<CR>", { desc = "Telescope NvChad themes" })
mapn(
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope find all files" }
)
mapa("<leader>v", "<cmd>Telescope neoclip<cr>", { desc = "Telescope Preview clipboard" })

-- Neogit
mapn("<leader>G", "<cmd>Neogit<cr>", { desc = "Neogit Open Neogit" })

-- Whichkey
mapn("<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey All keymaps" })
mapn("<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "Whichkey Query lookup" })

-- Blankline
mapa("<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "Navigation Jump to current context" })

-- Icon picker
mapn("<leader>i", "<cmd>IconPickerYank<cr>", { desc = "IconPicker Open icon picker" })
mapi("<M-i>", "<cmd>IconPickerInsert<cr>", { desc = "IconPicker Insert icon" })

-- Git conflict
mapn("<leader>Co", "<Plug>(git-conflict-ours)", { desc = "Conflict Choose ours" })
mapn("<leader>Ct", "<Plug>(git-conflict-theirs)", { desc = "Conflict Choose theirs" })
mapn("<leader>Cb", "<Plug>(git-conflict-both)", { desc = "Conflict Choose both" })
mapn("<leader>C0", "<Plug>(git-conflict-none)", { desc = "Conflict Choose none" })
mapn(
  "<leader>Cp",
  "<Plug>(git-conflict-prev-conflict)",
  { desc = "Conflict Move to previous conflict" }
)
mapn(
  "<leader>Cn",
  "<Plug>(git-conflict-next-conflict)",
  { desc = "Conflict Move to next conflict" }
)

-- Hop
mapa("<C-f>", "<cmd>HopWord<cr>", { desc = "Hop Word" })
mapa("<C-f>f", "<cmd>HopWord<cr>", { desc = "Hop Word" })
mapa("<C-f>c", "<cmd>HopChar1<cr>", { desc = "Hop One char" })
mapa("<C-f>C", "<cmd>HopChar2<cr>", { desc = "Hop Two chars" })
mapa("<C-f>/", "<cmd>HopPattern<cr>", { desc = "Hop Search pattern" })
mapa("<C-f>l", "<cmd>HopLineStart<cr>", { desc = "Hop Line start" })
mapa("<C-f>L", "<cmd>HopLine<cr>", { desc = "Hop Line" })

-- Leap
mapa("s", "<Plug>(leap-forward)", { desc = "Leap Leap forward", remap = true })
mapa("S", "<Plug>(leap-backward)", { desc = "Leap Leap backward", remap = true })
mapa("zs", "<Plug>(leap-from-window)", { desc = "Leap Leap from window", remap = true })

-- Spectre
mapn("<leader>sp", "<cmd>Spectre<cr>", { desc = "Spectre Open Spectre" })

-- Todo
mapn("[t", require("todo-comments").jump_prev, { desc = "Todo Jump to previous todo comment" })
mapn("]t", require("todo-comments").jump_next, { desc = "Todo Jump to previous todo comment" })
mapn("fq", "<cmd>TodoTelescope<CR>", { desc = "Todo Search all todo comments" })

-- Vim tmux
mapn("<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigation Window left" })
mapn("<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigation Window down" })
mapn("<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigation Window up" })
mapn("<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigation Window right" })

-- Conform
mapn("<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Conform Format file" })
