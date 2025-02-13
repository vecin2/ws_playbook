vim.g.mapleader= ' '
vim.g.maplocalleader = ' '

local opt = vim.opt
local opts = { noremap = true, silent = true }
local mapkey = require("util.keymapper").mapvimkey

--{{{ keymaps
vim.api.nvim_set_keymap("i", "jk", "<Esc>", opts) --easy exit insert mode
vim.api.nvim_set_keymap("n", ";", ":", {noremap =true}) --easy enter command mode
-- Delete a buffer without exiting window
vim.api.nvim_set_keymap('n', '\\d', ':bp<CR>:bd! #<CR>', opts)

-- <leader>-c redraws the screen and removes any search highlighting
vim.api.nvim_set_keymap('n', '<Leader>c', ':nohl<CR><C-l>', opts)

-- Change pwd to current parent folder
-- vim.api.nvim_set_keymap('n', 'cd.', ':lcd %:p:h<CR>:pwd<CR>', opts)
--
-- When 'wsl-open' available allow open windows explorer from current buffer
if vim.fn.executable('wsl-open') == 1 then
  vim.api.nvim_set_keymap('n', '<Leader>wo', ':!wsl-open %:p:h<CR>', opts)
end
--}}}

-- Folding {{{
--Cheatsheet
	--zi switch folding on or off
	--;a toggle current fold open/close
	--zc close current fold
	--zM close all folds, zm decreae the fold level (more folds)
	--zR close all folds, zr increate the fold level (less folds)
	--zv expand folds to reveal cursor
	--zx Recompute folds
	--zf Creates manual folder. E.g in html use zfat,zit to fold to the end tag
	-- Common options for key mappings to avoid duplication

	-- Folding configuration key mappings
	vim.keymap.set('n', ',', 'za', opts)          -- Toggle current fold open/close
	vim.keymap.set('n', '<leader>,', 'zMzv', opts) -- Close all folds and re-evaluate

	vim.opt.foldlevelstart = 0 --start file with all folds closed

	vim.opt.foldexpr = 'v:lua.wincent.foldexpr(v:lnum)' --function combines marker {{{ with indent folding
-- }}}

-- -- Vimscript folding {{{
-- local augroup = vim.api.nvim_create_augroup("filetype_vim", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   pattern = "vim",
--   callback = function()
--     vim.opt_local.foldmethod = "marker"
--   end,
-- })
-- -- }}}
--
-- -- Lua folding {{{
-- local augroup = vim.api.nvim_create_augroup("filetype_lua", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   pattern = "lua",
--   callback = function()
--     vim.opt_local.foldmethod = "marker"
--   end,
-- })
-- --}}}

-- -- xml folding {{{
-- local xml_augroup = vim.api.nvim_create_augroup("filetype_xml", { clear = true })
-- vim.g.xml_syntax_folding = 1
-- vim.api.nvim_create_autocmd("FileType", {
--   group = xml_augroup,
--   pattern = "xml",
--   callback = function()
--     vim.opt_local.foldmethod = "syntax"
--   end,
-- })
-- -- }}}

-- {{{ Indenting and Formating
vim.opt.smartindent = true
vim.opt.tabstop = 2         -- Number of spaces per tab
vim.opt.shiftwidth = 2      -- Number of spaces for each auto-indent
vim.opt.softtabstop = 2     -- Number of spaces for a Tab in Insert mode
-- }}}

-- Navigating Windows {{{
-- Force all vertical splits to go to the right of the current window
vim.opt.splitright = true

-- Force all horizontal splits to go below the current window
vim.opt.splitbelow = true


mapkey("<C-", "edit <cfile>", "n") -- "Allow gf to open non-existing files"

mapkey("<C-Up>", "resize +2","n")
mapkey("<C-Down>", "resize -2","n")
mapkey("<C-Left>", "vertical resize -2","n")
mapkey("<C-Right>", "vertical resize +2","n")
-- }}}

-- Clipboard settings {{{
-- Allows to paste text copied from Vim after exit Vim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.fn.system("xclip -o | xclip -selection c")
  end,
})

-- Set clipboard to unnamedplus
vim.opt.clipboard = "unnamedplus"

-- Prevent x from overriding what's in the clipboard
vim.api.nvim_set_keymap("n", "x", '"_x', opts)
vim.api.nvim_set_keymap("n", "X", '"_X', opts)
-- }}}
--
--Navigating docs {{{
vim.opt.backup = false --Remove backup files swp
vim.opt.swapfile = false
opt.undofile = true --persistent save
opt.hidden = true --Allow exit buffer without saving
opt.scrolloff=5 -- show 5 lines between cursor line and top or bottom line
opt.sidescrolloff=5 -- show 5 lines between cursor line and left or right line
opt.number = true -- Make line numbers default

vim.opt.mouse = 'a' -- Enable mouse mode, resizing splits for example!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.fillchars:append("vert:\\") ---- Remove vertical line on window splits
vim.opt.signcolumn = 'yes' --useful to show errors, warnings or git indicators
mapkey("gf", "edit <cfile>", "n") -- "Allow gf to open non-existing files"

--}}}

-- Navigating quick list{{{

vim.api.nvim_set_keymap("n", "<Up>", ":cprevious<CR>", opts)
vim.api.nvim_set_keymap("n", "<Down>", ":cnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<Left>", ":cpf<CR>", opts)
vim.api.nvim_set_keymap("n", "<Right>", ":cnf<CR>", opts)
-- }}}

-- Ctrl+S {{{
-- If the current buffer has never been saved, it will have no name,
-- " call the file browser to save it, otherwise just save it.

-- Define the Update command using vim.cmd
vim.api.nvim_create_user_command('Update', function()
  if vim.bo.modified then
    if vim.fn.bufname('%') == '' then
      -- If the buffer has no name, call the file browser to save it
      vim.cmd('browse confirm write')
    else
      -- Otherwise, just confirm and write
      vim.cmd('confirm write')
    end
  end
end, {})

-- Ctrl+S Save
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:Update<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-S>', ':<C-u>Update<CR>', opts)
-- }}}

-- {{{Set up a command for setting tabs
vim.api.nvim_create_user_command("Stab", function()
  -- Prompt user for tabstop value
  local tabstop = tonumber(vim.fn.input("set tabstop = softtabstop = shiftwidth = "))
  
  if tabstop and tabstop > 0 then
    -- Set the local options for tabstop, shiftwidth, and softtabstop
    vim.opt_local.tabstop = tabstop
    vim.opt_local.shiftwidth = tabstop
    vim.opt_local.softtabstop = tabstop
  end
  -- Call the function to summarize tab settings
  summarize_tabs()
end, {})

-- Function to summarize tab settings
function summarize_tabs()
  local success, _ = pcall(function()
    vim.api.nvim_echo({
      { " tabstop=" .. vim.opt_local.tabstop:get(), "ModeMsg" },
      { " shiftwidth=" .. vim.opt_local.shiftwidth:get(), "ModeMsg" },
      { " softtabstop=" .. vim.opt_local.softtabstop:get(), "ModeMsg" },
      { " expandtab=" .. tostring(vim.opt_local.expandtab:get()), "ModeMsg" }
    }, false, {})
  end)

  if not success then
    vim.api.nvim_echo({ { "Error summarizing tab settings.", "ErrorMsg" } }, true, {})
  end
end
--}}}
