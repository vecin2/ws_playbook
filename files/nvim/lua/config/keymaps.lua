--globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mapkey = require("util.keymapper").mapvimkey
-- Docs navigation
mapkey("gf", "edit <cfile>", "n") -- "Allow gf to open non-existing files"


