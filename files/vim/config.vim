"Colors {{{
"let base16colorspace=256
"let base16colorspace=256
"if filereadable(expand("~/.vimrc_background"))
"	    source ~/.vimrc_background
"endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  set background=dark
  colorscheme gruvbox
  let g:gruvbox_italic=1
	highlight Comment cterm=italic
endif

"" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
"}}}

"Coding settings {{{
set tags +=.git/tags
" }}}

"Python settings{{{
augroup filetype_py
	autocmd!
	autocmd FileType python : set colorcolumn =88
"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  #exec(activate_this, dict(__file__=activate_this))
  #exec(open(filename).read())
  with open(activate_this) as infile:
      exec(infile.read(),dict(__file__=activate_this))

EOF

"}}}

"yaml settings{{{
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
"}}}

"Vimscript file setting ----- {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}

" Folding {{{
"Cheatsheet
	"zi switch folding on or off
	"za toggle current fold open/close
	"zc close current fold
	"zM close all folds, zm decreae the fold level (more folds)
	"zR close all folds, zr increate the fold level (less folds)
	"zv expand folds to reveal cursor
	"zx Recompute folds
	nnoremap , za
	nnoremap <leader>, zMzv
	"xml folding
	let g:xml_syntax_folding=1
	au FileType xml setlocal foldmethod=syntax
" }}}

	"Searching {{{
	"search by files completing like sh
	set wildmode=longest,list
	"allow searching in subdirectories
	set path+=**
	" hilight searched term
	set hlsearch
	"Allows vim to use ag with ack plugin
	let g:ackprg = 'ag --nogroup --nocolor --column'
	nnoremap <leader>a <Esc>:Ack!
	"}}}

	"Clipboard settings {{{
	"Allows to paste text copied from Vim after exit vim
	autocmd VimLeave * call system("xclip -o | xclip -selection c")
	set clipboard=unnamedplus
	" Prevent x from overriding what's in the clipboard.
	noremap x "_x
	noremap X "_X

	"}}}

	"Navigating docs {{{
	"Remove backup files swp
	set nobackup nowritebackup
	"Allow exit buffer without saving
	set hidden
	" Always show 5 lines between current cursor line and top or bottom line
	set scrolloff=5
	"set relativenumber and absolute number for current line
	"set rnu
	set number
	set cursorline
	"This map allows to use the arrow keys in insert mode. Otherwise it shows
	"strange characters
	map OA <up>
	map OB <down>
	map OC <right>
	map OD <left>
	"}}}

	"Highlight current line number but not line{{{
	hi clear CursorLine
	augroup CLClear
		autocmd! ColorScheme * hi clear CursorLine
	augroup END
	hi CursorLineNR cterm=bold
	augroup CLNRSet
		autocmd! ColorScheme * hi CursorLineNR cterm=bold
	augroup END
	"}}}

	"Status Line {{{
	"Display status line always
	set laststatus=2
	function! GitBranch()
			return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	endfunction

	function! StatuslineGit()
			let l:branchname = GitBranch()
			return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
	endfunction
	"
	set statusline=
	set statusline+=%#PmenuSel#
	"set statusline+=%{StatuslineGit()}
	set statusline+=%#LineNr#
	set statusline+=\ %f
	set statusline+=%m\
	set statusline+=%=
	set statusline+=%#CursorColumn#
	set statusline+=\ %y
	set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
	set statusline+=\[%{&fileformat}\]
	set statusline+=\ %p%%
	set statusline+=\ %l:%c
	set statusline+=%#warningmsg#
	set statusline+=%*
	"ALE
	"set statusline+=\
	"function! LinterStatus() abort
	"	let l:counts = ale#statusline#Count(bufnr(''))
	"	let l:all_errors = l:counts.error + l:counts.style_error
	"	let l:all_non_errors = l:counts.total - l:all_errors
	"	return l:counts.total == 0 ? 'OK' : printf(
	"				\   '%d⨉ %d⚠ ',
	"				\   all_non_errors,
	"				\   all_errors
	"				\)
	"endfunction
	"set statusline+=%=
	"set statusline+=\ %{LinterStatus()}
	"}}}

	"Mouse config {{{
	set mouse=a  "enable mouse
	set ttymouse=sgr
	" }}}

	"Global Remaps{{{
	let mapleader="\<Space>"
	:inoremap jk <Esc>
	"Uncommenting the below lines causes characters to appear when mouse events
	"occur in insert mode
	":inoremap <Esc> <nop>

	noremap ; :
	"noremap : <nop>
	"}}}

	"Other Vim remaps {{{
	"To allow NERDTREE delete a buffer without exiting window
	nnoremap \d :bp<cr>:bd! #<cr>
	" <leader>-c redraws the screen and removes any search highlighting.
	nnoremap <silent> <Leader>c :nohl<CR><C-l>
	"Change root dir to current
	command! Cdw :execute "lcd" . fnamemodify(resolve(expand('%')),':p:h')
	"nnoremap cd. :lcd %:p:h<CR>:pwd<CR>
	nnoremap cd. :Cdw
	"}}}

	" Ctrl+S {{{
	" If the current buffer has never been saved, it will have no name,
	" " call the file browser to save it, otherwise just save it.
	command! -nargs=0 -bar Update if &modified
				\|    if empty(bufname('%'))
					\|        browse confirm write
					\|     else
						\|        confirm write
					\|     endif
					\|endif
	"Ctrl+s Save
	nnoremap <silent><C-S> :<C-u>Update<CR>
	inoremap <c-s> <Esc>:Update<CR>
	" }}}

	" Ctrl+z Zoom / Restore window {{{
	function! s:ZoomToggle() abort
		if exists('t:zoomed') && t:zoomed
			execute t:zoom_winrestcmd
			let t:zoomed = 0
		else
			let t:zoom_winrestcmd = winrestcmd()
			resize
			vertical resize
			let t:zoomed = 1
		endif
	endfunction
	command!  ZoomToggle call s:ZoomToggle()
	nnoremap <silent> <C-w>z :ZoomToggle<CR>
	"}}}

	"Ctrl+UP(Down) -Bubble single lines{{{
	map <ESC>[1;5A <C-Up>
	map <ESC>[1;5B <C-Down>
	nmap <C-Up> ddkP
	nmap <C-Down> ddp
	"Buble multiple lines
	vmap <C-Up> xkP`[V`]
	vmap <C-Down> xp`[V`]
	"}}}

	"Setting tabs Set tabstop, softtabstop and shiftwidth to the same value {{{
	command! -nargs=* Stab call Stab()
	function! Stab()
			let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
			if l:tabstop > 0
					let &l:sts = l:tabstop
					let &l:ts = l:tabstop
					let &l:sw = l:tabstop
			endif
			call SummarizeTabs()
	endfunction

	function! SummarizeTabs()
			try
					echohl ModeMsg
					echon 'tabstop='.&l:ts
					echon ' shiftwidth='.&l:sw
					echon ' softtabstop='.&l:sts
					if &l:et
							echon ' expandtab'
					else
							echon ' noexpandtab'
					endif
			finally
					echohl None
			endtry
	endfunction
	" }}}

	" Shorcuts to main docs {{{
	nnoremap <Leader>kl :e $CLOUD_LOC/links/kanaLinks.txt<CR>
	nnoremap <Leader>pl :e $CLOUD_LOC/links/links.txt<CR>
	"nnoremap <Leader>adl :e $EM_CORE_HOME/docs/links.txt<CR>
	nnoremap <Leader>mv :e $MYVIMRC<CR> "Edit MYVIMRC
	nnoremap <Leader>mc :e ~/.vim/config.vim<CR> "Edit config.vim
	nnoremap <Leader>mp :e ~/.vim/plugins.vim<CR> "Edit plugins.vim
	"nnoremap <Leader>pn :e $EM_CORE_HOME/docs/notes.txt<CR>
"}}}



" Shorcuts to main docs {{{
command! Kernel execute 'edit'  "$EM_CORE_HOME/logs/ad/cre/kernel/kernel.log"
command! Stdout execute 'edit'  "$EM_CORE_HOME/logs/ad/weblogic/stdout.log"

function! s:Vpl(...)
	let tail_no = get(a:, 1, 1)
	let pl_path= "$EM_CORE_HOME/logs/ad/cre/session/process/"
	let file_name=system("ls  -ltr " . pl_path . " | grep process | tail -".tail_no." | head -1 | rev | cut -d \" \" -f1 | rev")
	let file_name=substitute(file_name,'%','\\%',"g")
	execute "edit" . pl_path . file_name
endfunction
command! -nargs=? Vpl call s:Vpl(<f-args>)
"}}}
