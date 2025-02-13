--globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mapkey = require("util.keymapper").mapvimkey

-- Docs navigation
mapkey("gf", "edit <cfile>", "n") -- "Allow gf to open non-existing files"
vim.keymap.set('n', 'zj', 'zjz', { desc = 'Move folds down easily' })

vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = 'Source current line in vim' })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = 'Source current line in vim' })


