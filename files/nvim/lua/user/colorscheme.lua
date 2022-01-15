vim.cmd [[
try
  colorscheme gruvbox
  let g:gruvbox_italic=1
	highlight Comment cterm=italic
  set termguicolors

catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
