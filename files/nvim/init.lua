--require "user.options"
require "dgarcia.plugins"
--vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme gruvbox]])
--vim.cmd([[let g:gruvbox_italic=1]])


vim.cmd 'so ~/.config/nvim/config.vim'

vim.cmd 'so ~/.config/nvim/plugins.vim'

--require "user.colorscheme"
require "dgarcia.cmp"
require "user.lsp"
--
--
require "dgarcia.telescope"
require "user.treesitter"
--require "user.autopairs"
--require "user.comment"
--require "user.gitsigns"
--require "user.nvim-tree"
--require "user.bufferline"
--require "user.lualine"
--require "user.toggleterm"
--require "user.project"
--require "user.impatient"
--require "user.indentline"
--require "user.alpha"
--require "user.whichkey"
--require "user.autocommands"
