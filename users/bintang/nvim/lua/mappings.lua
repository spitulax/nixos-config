local map = vim.keymap.set
local utils = require("utils")

-- Default keybinds
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })
-- map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })
map({"n", "v"}, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map({"n", "v"}, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })

-- Evil mode (yikes)
map("i", "<C-b>", "<Left>", { desc = "Move left" })
map("i", "<C-f>", "<Right>", { desc = "Move right" })
map("i", "<C-n>", "<Down>", { desc = "Move down" })
map("i", "<C-p>", "<Up>", { desc = "Move up" })
map("i", "<C-h>", "<BS>", { desc = "Backspace" })
map("i", "<C-d>", "<kDel>", { desc = "Delete" })
map("i", "<M-d>", "<Esc>ldei", { desc = "Delete next word" })
map("i", "<C-k>", "<Esc>lDa", { desc = "Delete from cursor to end of line" })
map("i", "<C-a>", "<Esc>^i", { desc = "Go to start of the line" })
map("i", "<C-e>", "<End>", { desc = "Go to end of the line" })
map("i", "<M-b>", "<Esc>bi", { desc = "Go to previous word" })
map("i", "<M-f>", "<Esc>lea", { desc = "Go to next word" })

-- Shortcuts
map({"n", "v"}, "!", ":!", { desc = "Enter shell command mode", nowait = true })
-- map("n", "<leader>rt", require("base46").load_all_highlights, { desc = "Reload highlights" })
map({"n", "v"}, "<C-p>", "\"+p", { desc = "Paste from + register (p)" })
map({"n", "v"}, "<M-p>", "\"+P", { desc = "Paste from + register (P)" })
map({"n", "v"}, "<C-y>", "\"+y", { desc = "Yank to + register" })
map({"n", "v"}, "<leader>Q", "<cmd>qa<cr>", { desc = "Close Neovim" })
map({"n", "v"}, "(", "zh", { desc = "Scroll to left" })
map({"n", "v"}, ")", "zl", { desc = "Scroll to right" })
map({"n", "v"}, "H", "zH", { desc = "Half screen to left" })
map({"n", "v"}, "L", "zL", { desc = "Half screen to right" })
map({"n", "v"}, "<A-<>", "gg", { desc = "Move to beginning of buffer" })
map({"n", "v"}, "<A->>", "G", { desc = "Move to end of buffer" })
map("v", "<C-n>", ":norm ", { desc = "Execute normal mode commands", nowait = true })
map("t", "<C-\\>", "<C-\\><C-n>", { desc = "Leave terminal mode", silent = true, nowait = true })
map("t", "<C-d>", "<C-\\><C-n><C-w>q", { desc = "Close terminal", silent = true, nowait = true })

-- Buffer management
map("n", "<M-.>", "<cmd>bn<cr>", { desc = "Go to next buffer" })
map("n", "<M-,>", "<cmd>bp<cr>", { desc = "Go to previous buffer" })
map("n", "<leader>x",
  function()
    MiniBufremove.delete(0)
  end,
  { desc = "Close current buffer" })
map("n", "<leader>X",
  function()
    MiniBufremove.delete(vim.fn.bufnr("#"))
  end,
  { desc = "Close previous buffer" })
map("n", "<leader>bo",
  function()
    for i = 1, vim.fn.bufnr('$') do
      if vim.fn.bufexists(i) == 1 and i ~= vim.fn.bufnr('%') then
        MiniBufremove.delete(i)
      end
    end
  end,
  { desc = "Close all other buffers" })
map("n", "<leader>bx",
  function()
    for i = 1, vim.fn.bufnr('$') do
      if vim.fn.bufexists(i) == 1 then
        MiniBufremove.delete(i)
      end
    end
  end,
  { desc = "Close all buffers" })
map("n", "<leader>S",
  function()
    local buf = vim.api.nvim_create_buf(true, true)
    if buf ~= 0 then vim.api.nvim_set_current_buf(buf) end
  end,
  { desc = "Create a scratch buffer "})

-- Window and tab management
map("n", "<M-w>", "<C-w>|", { desc = "Max out window width" })
map("n", "<M-u>", "<C-w>_", { desc = "Max out window height" })
map("n", "<C-c>", "<C-w>q", { desc = "Close current window" })
map("n", "<M-c>", "<C-w>o", { desc = "Close all other windows" })
map("n", "<M-=>", "<C-w>+", { desc = "Increase window height" })
map("n", "<M-->", "<C-w>-", { desc = "Decrease window height" })
map("n", "<M-]>", "<C-w>>", { desc = "Increase window width" })
map("n", "<M-[>", "<C-w><", { desc = "Decrease window width" })
map("n", "<M-e>", "<C-w>=", { desc = "Uniform window size" })
map("n", "<M-t>", "<cmd>tabnew<cr>", { desc = "Create new tab" })
map("n", "<M-q>", "<cmd>tabclose<cr>", { desc = "Close current tab" })
map("n", "<M-a>", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })

-- Toggles
map("n", "<leader>tw",
  function()
    vim.o.wrap = not vim.o.wrap
  end,
  { desc = "Toggle line wrap" })

-- LSP
map("n", "<leader>dq",
  function()
    vim.diagnostic.setloclist()
  end, { desc = "LSP Diagnostic loclist" })
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
  { desc = "Toggle comment" })
map( "v", "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Toggle comment" })

-- Neorg
map("n", "<leader>N", "<cmd>Neorg toc<cr>", { desc = "Toggle table of contents in norg files" })

-- Nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvimtree", nowait = true })
map("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Focus nvimtree", nowait = true })

-- Gitsigns
map("n", "<leader>B", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle current line blame" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope resume <CR>", { desc = "Telescope resume" })
map("n", "<leader>fe",
  function()
    utils.prompt_callback("Find files in", "file", function(input)
      vim.cmd("Telescope find_files cwd=" .. input)
    end)
  end,
  { desc = "Telescope find files in specified directory" })
map("n", "<leader>o", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
map("n", "<M-b>", "<cmd>Telescope buffers<cr>", { desc = "Telescope find buffers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope find keybindings" })
map("n", "<leader>ft", "<cmd>Telescope builtin<cr>", { desc = "Telescope builtin commands" })
map("n", "<leader>fc", "<cmd>Telescope highlights<cr>", { desc = "Telescope builtin commands" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
map("n", "<leader>gs", "<cmd>Telescope git_stash<cr>", { desc = "Git stash" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope find in current buffer" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })
map("n", "<leader>tt", "<cmd>Telescope themes<CR>", { desc = "Telescope nvchad themes" })
map("n", "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope find all files" })
map("n", "<leader>v", "<cmd>Telescope neoclip<cr>", { desc = "Preview clipboard" })

-- Neogit
map("n", "<leader>G", "<cmd>Neogit<cr>", { desc = "Open Neogit" })

-- Whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey all keymaps" })
map("n", "<leader>wk",
  function()
    vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
  end,
  { desc = "Whichkey query lookup" })

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
  { desc = "Jump to current context" })

-- Icon picker
map("n", "<leader>i", "<cmd>IconPickerYank<cr>", { desc = "Open icon picker" })
map("i", "<M-i>", "<cmd>IconPickerInsert<cr>", { desc = "Insert icon" })

-- Git conflict
map("n", "<leader>Co", "<Plug>(git-conflict-ours)", { desc = "Choose ours" })
map("n", "<leader>Ct", "<Plug>(git-conflict-theirs)", { desc = "Choose theirs" })
map("n", "<leader>Cb", "<Plug>(git-conflict-both)", { desc = "Choose both" })
map("n", "<leader>C0", "<Plug>(git-conflict-none)", { desc = "Choose none" })
map("n", "<leader>Cp", "<Plug>(git-conflict-prev-conflict)", { desc = "Move to previous conflict" })
map("n", "<leader>Cn", "<Plug>(git-conflict-next-conflict)", { desc = "Move to next conflict" })

-- Hop
map({"n", "v"}, "<C-f>", "<cmd>HopWord<cr>", { desc = "Hop word" })
map({"n", "v"}, "<C-f>f", "<cmd>HopWord<cr>", { desc = "Hop word" })
map({"n", "v"}, "<C-f>c", "<cmd>HopChar1<cr>", { desc = "Hop one char" })
map({"n", "v"}, "<C-f>C", "<cmd>HopChar2<cr>", { desc = "Hop two chars" })
map({"n", "v"}, "<C-f>/", "<cmd>HopPattern<cr>", { desc = "Hop search pattern" })
map({"n", "v"}, "<C-f>l", "<cmd>HopLineStart<cr>", { desc = "Hop line start" })
map({"n", "v"}, "<C-f>L", "<cmd>HopLine<cr>", { desc = "Hop line" })

-- Spectre
map("n", "<leader>sp", "<cmd>Spectre<cr>", { desc = "Open Spectre" })

-- Todo
map("n", "[t", require("todo-comments").jump_prev, { desc = "Jump to previous todo comment" })
map("n", "]t", require("todo-comments").jump_next, { desc = "Jump to previous todo comment" })
map("n", "fq", "<cmd>TodoTelescope<CR>", { desc = "Search all todo comments" })

-- Vim tmux
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window right" })

-- Conform
map("n", "<leader>fm",
  function()
    require("conform").format { lsp_fallback = true }
  end,
  { desc = "Format file" })
