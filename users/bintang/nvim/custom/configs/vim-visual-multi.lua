local leader = "\\\\"

vim.g.VM_default_mappings = 0

-- Permanent mappings
vim.keymap.set("n", "<S-l>", "<Plug>(VM-Select-l)")
vim.keymap.set("n", "<S-h>", "<Plug>(VM-Select-h)")
vim.keymap.set("n", "<C-m>", "<Plug>(VM-Find-Under)")
vim.keymap.set("n", leader .. "A", "<Plug>(VM-Select-All)")
vim.keymap.set("n", leader .. "/", "<Plug>(VM-Start-Regex-Search)")
vim.keymap.set("n", "<A-j>", "<Plug>(VM-Add-Cursor-Down)")
vim.keymap.set("n", "<A-k>", "<Plug>(VM-Add-Cursor-Up)")
vim.keymap.set("n", leader .. "\\", "<Plug>(VM-Add-Cursor-At-Pos)")

-- Visual permanent mappings
vim.keymap.set("v", "<C-m>", "<Plug>(VM-Find-Subword-Under)")
vim.keymap.set("v", leader .. "/", "<Plug>(VM-Visual-Regex)")
vim.keymap.set("v", leader .. "A", "<Plug>(VM-Visual-All)")
vim.keymap.set("v", leader .. "a", "<Plug>(VM-Visual-Add)")
-- vim.keymap.set("x", leader .. "f", "<Plug>(VM-Visual-Find)")
vim.keymap.set("v", leader .. "c", "<Plug>(VM-Visual-Cursors)")

-- Buffer mappings
vim.keymap.set("x", "<Tab>", "<Plug>(VM-Switch-Mode)")
vim.keymap.set("x", "]", "<Plug>(VM-Find-Next)")
vim.keymap.set("x", "[", "<Plug>(VM-Find-Prev)")
-- vim.keymap.set("x", "}", "<Plug>(VM-Goto-Next)")
-- vim.keymap.set("x", "{", "<Plug>(VM-Goto-Prev)")
-- vim.keymap.set("x", "<C-f>", "<Plug>(VM-Seek-Next)")
-- vim.keymap.set("x", "<C-b>", "<Plug>(VM-Seek-Prev)")
vim.keymap.set("x", "q", "<Plug>(VM-Skip-Region)")
vim.keymap.set("x", "Q", "<Plug>(VM-Remove-Region)")

-- Run
-- vim.keymap.set("x", leader .. "z", "<Plug>(VM-Run-Normal)")
-- vim.keymap.set("x", leader .. "Z", "<Plug>(VM-Run-Last-Normal)")
-- vim.keymap.set("x", leader .. "v", "<Plug>(VM-Run-Visual)")
-- vim.keymap.set("x", leader .. "V", "<Plug>(VM-Run-Last-Visual)")
-- vim.keymap.set("x", leader .. "x", "<Plug>(VM-Run-Ex)")
-- vim.keymap.set("x", leader .. "X", "<Plug>(VM-Run-Last-Ex)")
-- vim.keymap.set("x", leader .. "@", "<Plug>(VM-Run-Macro)")

-- Misc.
vim.keymap.set("x", "u", "<Plug>(VM-Undo)")
vim.keymap.set("x", "<C-r>", "<Plug>(VM-Redo)")
vim.keymap.set("x", leader .. "`", "<Plug>(VM-Tools-Menu)")
vim.keymap.set("x", "R", "<Plug>(VM-Replace-Pattern)")
vim.keymap.set("x", "m", "<Plug>(VM-Find-Operator)")

-- Unsorted
-- vim.keymap.set("n", leader .. "t", "<Plug>(VM-Transpose)")
-- vim.keymap.set("n", leader .. "=", "<Plug>(VM-Align)")
-- vim.keymap.set("", "o", "<Plug>(VM-Invert-Direction)")
-- vim.keymap.set("", "<C-M-j>", "<Plug>(VM-Select-Cursor-Down)")
-- vim.keymap.set("", "<C-M-k>", "<Plug>(VM-Select-Cursor-Up)")
-- vim.keymap.set("", "S", "<Plug>(VM-Surround)")
-- vim.keymap.set("", leader .. "\"", "<Plug>(VM-Show-Registers)")
-- vim.keymap.set("", leader .. "c", "<Plug>(VM-Case-Setting)")
-- vim.keymap.set("", leader .. "w", "<Plug>(VM-Toggle-Whole-Word)")
-- vim.keymap.set("", leader .. "d", "<Plug>(VM-Duplicate)")
-- vim.keymap.set("", leader .. "r", "<Plug>(VM-Rewrite-Last-Search)")
-- vim.keymap.set("", leader .. "m", "<Plug>(VM-Merge-Regions)")
-- vim.keymap.set("", leader .. "s", "<Plug>(VM-Split-Regions)")
-- vim.keymap.set("", leader .. "q", "<Plug>(VM-Remove-Last-Region)")
-- vim.keymap.set("", leader .. "s", "<Plug>(VM-Visual-Subtract)")
-- vim.keymap.set("", leader .. "C", "<Plug>(VM-Case-Conversion-Menu)")
-- vim.keymap.set("", leader .. "S", "<Plug>(VM-Search-Menu)")
-- vim.keymap.set("", leader .. "<", "<Plug>(VM-Align-Char)")
-- vim.keymap.set("", leader .. ">", "<Plug>(VM-Align-Regex)")
-- vim.keymap.set("", leader .. "n", "<Plug>(VM-Numbers)")
-- vim.keymap.set("", leader .. "N", "<Plug>(VM-Numbers-Append)")
-- vim.keymap.set("", leader .. "0n", "<Plug>(VM-Zero-Numbers)")
-- vim.keymap.set("", leader .. "0N", "<Plug>(VM-Zero-Numbers-Append)")
-- vim.keymap.set("", leader .. "-", "<Plug>(VM-Shrink)")
-- vim.keymap.set("", leader .. "+", "<Plug>(VM-Enlarge)")
-- vim.keymap.set("", leader .. "<BS>", "<Plug>(VM-Toggle-Block)")
-- vim.keymap.set("", leader .. "<CR>", "<Plug>(VM-Toggle-Single-Region)")
-- vim.keymap.set("", leader .. "M", "<Plug>(VM-Toggle-Multiline)")
