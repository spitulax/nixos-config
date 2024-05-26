local map = vim.keymap.set
local unmap = vim.keymap.del
local utils = require("utils")

-- General
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save file" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "General Toggle nvcheatsheet" })
map({"n", "v"}, "!", ":!", { desc = "General Enter shell command mode", nowait = true })
map("n", "<leader>rt", require("base46").load_all_highlights, { desc = "General Reload highlights" })
map({"n", "v"}, "<leader>Q", "<cmd>qa<cr>", { desc = "General Close Neovim" })
map("v", "<C-n>", ":norm ", { desc = "General Execute normal mode commands", nowait = true })

-- Navigation
map({"n", "v"}, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Navigation Move down", expr = true })
map({"n", "v"}, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Navigation Move up", expr = true })
map({"n", "v"}, "(", "zh", { desc = "Navigation Scroll left" })
map({"n", "v"}, ")", "zl", { desc = "Navigation Scroll right" })
map({"n", "v"}, "<C-->", "<C-y>", { desc = "Navigation Scroll down" })
map({"n", "v"}, "<C-=>", "<C-e>", { desc = "Navigation Scroll up" })
map({"n", "v"}, "H", "zH", { desc = "Navigation Half screen to left" })
map({"n", "v"}, "L", "zL", { desc = "Navigation Half screen to right" })
map({"n", "v"}, "<M-<>", "gg", { desc = "Navigation Move to beginning of buffer" })
map({"n", "v"}, "<M->>", "G", { desc = "Navigation Move to end of buffer" })
map({"n", "v"}, "gt", "<C-]>", { desc = "Navigation Jump to tag definition under cursor" })
map({"n", "v"}, "<M-g>t", "<C-W>]", { desc = "Navigation Jump to tag definition under (split window)" })

-- Terminal
map("t", "<C-\\>", "<C-\\><C-n>", { desc = "Terminal Leave terminal mode", silent = true, nowait = true })
map("t", "<C-d>", "<C-\\><C-n><C-w>q", { desc = "Terminal Close terminal", silent = true, nowait = true })

-- Clipboard
map({"n", "v"}, "<C-p>", "\"+p", { desc = "Clipboard Paste (p)" })
map({"n", "v"}, "<M-p>", "\"+P", { desc = "Clipboard Paste (P)" })
map({"n", "v"}, "<C-y>", "\"+y", { desc = "Clipboard Yank" })

-- Evil mode (yikes)
map("i", "<C-b>", "<Left>", { desc = "Evil Move left" })
map("i", "<C-f>", "<Right>", { desc = "Evil Move right" })
map("i", "<C-n>", "<Down>", { desc = "Evil Move down" })
map("i", "<C-p>", "<Up>", { desc = "Evil Move up" })
map("i", "<C-h>", "<BS>", { desc = "Evil Backspace" })
map("i", "<C-d>", "<kDel>", { desc = "Evil Delete" })
map("i", "<M-d>", "<Esc>ldei", { desc = "Evil Delete next word" })
map("i", "<C-k>", "<Esc>lDa", { desc = "Evil Delete from cursor to end of line" })
map("i", "<C-a>", "<Esc>^i", { desc = "Evil Go to start of the line" })
map("i", "<C-e>", "<End>", { desc = "Evil Go to end of the line" })
map("i", "<M-b>", "<Esc>bi", { desc = "Evil Go to previous word" })
map("i", "<M-f>", "<Esc>lea", { desc = "Evil Go to next word" })

-- Buffer management
map("n", "<M-.>", "<cmd>bn<cr>", { desc = "Buffer Go to next buffer" })
map("n", "<M-,>", "<cmd>bp<cr>", { desc = "Buffer Go to previous buffer" })
map("n", "<leader>x",
  function()
    MiniBufremove.delete(0)
  end,
  { desc = "Buffer Close current buffer" })
map("n", "<leader>X",
  function()
    MiniBufremove.delete(vim.fn.bufnr("#"))
  end,
  { desc = "Buffer Close previous buffer" })
map("n", "<leader>bo",
  function()
    for i = 1, vim.fn.bufnr('$') do
      if vim.fn.bufexists(i) == 1 and i ~= vim.fn.bufnr('%') then
        MiniBufremove.delete(i)
      end
    end
  end,
  { desc = "Buffer Close all other buffers" })
map("n", "<leader>bx",
  function()
    for i = 1, vim.fn.bufnr('$') do
      if vim.fn.bufexists(i) == 1 then
        MiniBufremove.delete(i)
      end
    end
  end,
  { desc = "Buffer Close all buffers" })
map("n", "<leader>S",
  function()
    local buf = vim.api.nvim_create_buf(true, true)
    if buf ~= 0 then vim.api.nvim_set_current_buf(buf) end
  end,
  { desc = "Buffer Create a scratch buffer "})

-- Window and tab management
map("n", "<M-w>", "<C-w>|", { desc = "Window Max out window width" })
map("n", "<M-u>", "<C-w>_", { desc = "Window Max out window height" })
map("n", "<C-c>", "<C-w>q", { desc = "Window Close current window" })
map("n", "<M-c>", "<C-w>o", { desc = "Window Close all other windows" })
map("n", "<M-=>", "<C-w>+", { desc = "Window Increase window height" })
map("n", "<M-->", "<C-w>-", { desc = "Window Decrease window height" })
map("n", "<M-]>", "<C-w>>", { desc = "Window Increase window width" })
map("n", "<M-[>", "<C-w><", { desc = "Window Decrease window width" })
map("n", "<M-e>", "<C-w>=", { desc = "Window Uniform window size" })
map("n", "<M-o>", "<C-w>p", { desc = "Window Go to previous window" })
map("n", "<M-t>", "<cmd>tabnew<cr>", { desc = "Tab Create new tab" })
map("n", "<M-q>", "<cmd>tabclose<cr>", { desc = "Tab Close current tab" })
map("n", "<M-a>", "<cmd>tabonly<cr>", { desc = "Tab Close all other tabs" })
map("n", "<M-f>", "gt", { desc = "Tab Go to next tab" })
map("n", "<M-b>", "gT", { desc = "Tab Go to previous tab" })

-- Toggles
map("n", "<leader>tw",
  function()
    vim.o.wrap = not vim.o.wrap
  end,
  { desc = "Toggle Line wrap" })

-- LSP
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })
map("n", "<leader>dt",
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { desc = "LSP Toggle diagnostic" })
map("n", "<M-d>",
  function()
    vim.diagnostic.open_float({ border = "rounded" })
  end,
  { desc = "LSP Floating diagnostic" })
map("n", "<leader>[d",
  function()
    vim.diagnostic.goto_prev({ float = { border = "rounded" } })
  end,
  { desc = "LSP Previous diagnostic" })
map("n", "<leader>]d",
  function()
    vim.diagnostic.goto_next({ float = { border = "rounded" } })
  end,
  { desc = "LSP Next diagnostic" })

-- Comment
map("n", "<leader>/",
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { desc = "Comment Toggle comment" })
map("v", "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment Toggle comment" })

-- Neorg
map("n", "<M-g>O", "<cmd>Neorg toc<cr>", { desc = "Neorg Toggle table of contents" })

-- Nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle nvimtree", nowait = true })
map("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus nvimtree", nowait = true })

-- Gitsigns
map("n", "<leader>B", "<cmd>Gitsigns blame_line<CR>", { desc = "Gitsigns Blame line" })
map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Gitsigns Toggle current line blame" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope resume <CR>", { desc = "Telescope Resume" })
map("n", "<leader>fe",
  function()
    utils.prompt_callback("Find files in", "file", function(input)
      vim.cmd("Telescope find_files cwd=" .. input)
    end)
  end,
  { desc = "Telescope Find files in specified directory" })
map("n", "<leader>o", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<C-b>", "<cmd>Telescope buffers<cr>", { desc = "Telescope Find buffers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope Find keybindings" })
map("n", "<leader>ft", "<cmd>Telescope builtin<cr>", { desc = "Telescope Builtin commands" })
map("n", "<leader>fc", "<cmd>Telescope highlights<cr>", { desc = "Telescope Color highlights" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope Git branches" })
map("n", "<leader>gs", "<cmd>Telescope git_stash<cr>", { desc = "Telescope Git stash" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })
map("n", "<leader>tt", "<cmd>Telescope themes<CR>", { desc = "Telescope NvChad themes" })
map("n", "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope find all files" })
map("n", "<leader>v", "<cmd>Telescope neoclip<cr>", { desc = "Telescope Preview clipboard" })

-- Neogit
map("n", "<leader>G", "<cmd>Neogit<cr>", { desc = "Neogit Open Neogit" })

-- Whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey All keymaps" })
map("n", "<leader>wk",
  function()
    vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
  end,
  { desc = "Whichkey Query lookup" })

-- Blankline
map("n", "<leader>cc",
  function()
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
  end,
  { desc = "Navigation Jump to current context" })

-- Icon picker
map("n", "<leader>i", "<cmd>IconPickerYank<cr>", { desc = "IconPicker Open icon picker" })
map("i", "<M-i>", "<cmd>IconPickerInsert<cr>", { desc = "IconPicker Insert icon" })

-- Git conflict
map("n", "<leader>Co", "<Plug>(git-conflict-ours)", { desc = "Conflict Choose ours" })
map("n", "<leader>Ct", "<Plug>(git-conflict-theirs)", { desc = "Conflict Choose theirs" })
map("n", "<leader>Cb", "<Plug>(git-conflict-both)", { desc = "Conflict Choose both" })
map("n", "<leader>C0", "<Plug>(git-conflict-none)", { desc = "Conflict Choose none" })
map("n", "<leader>Cp", "<Plug>(git-conflict-prev-conflict)", { desc = "Conflict Move to previous conflict" })
map("n", "<leader>Cn", "<Plug>(git-conflict-next-conflict)", { desc = "Conflict Move to next conflict" })

-- Hop
map({"n", "v"}, "<C-f>", "<cmd>HopWord<cr>", { desc = "Hop Word" })
map({"n", "v"}, "<C-f>f", "<cmd>HopWord<cr>", { desc = "Hop Word" })
map({"n", "v"}, "<C-f>c", "<cmd>HopChar1<cr>", { desc = "Hop One char" })
map({"n", "v"}, "<C-f>C", "<cmd>HopChar2<cr>", { desc = "Hop Two chars" })
map({"n", "v"}, "<C-f>/", "<cmd>HopPattern<cr>", { desc = "Hop Search pattern" })
map({"n", "v"}, "<C-f>l", "<cmd>HopLineStart<cr>", { desc = "Hop Line start" })
map({"n", "v"}, "<C-f>L", "<cmd>HopLine<cr>", { desc = "Hop Line" })

-- Spectre
map("n", "<leader>sp", "<cmd>Spectre<cr>", { desc = "Spectre Open Spectre" })

-- Todo
map("n", "[t", require("todo-comments").jump_prev, { desc = "Todo Jump to previous todo comment" })
map("n", "]t", require("todo-comments").jump_next, { desc = "Todo Jump to previous todo comment" })
map("n", "fq", "<cmd>TodoTelescope<CR>", { desc = "Todo Search all todo comments" })

-- Vim tmux
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigation Window left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigation Window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigation Window up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigation Window right" })

-- Conform
map("n", "<leader>fm",
  function()
    require("conform").format { lsp_fallback = true }
  end,
  { desc = "Conform Format file" })
