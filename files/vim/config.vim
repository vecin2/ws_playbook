"Colors {{{
"let base16colorspace=256
"if filereadable(expand("~/.vimrc_background"))
"	    source ~/.vimrc_background
"endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[49;2;%lu;%lu;%lum"
  set termguicolors
  set background=dark
  let g:gruvbox_italic=1
  colorscheme darkplus
	highlight Comment cterm=italic
endif
"}}}
"w gf to open non-existing files

" Folding {{{
"Cheatsheet
	"zi switch folding on or off
	"za toggle current fold open/close
	"zc close current fold
	"zM close all folds, zm decreae the fold level (more folds)
	"zR close all folds, zr increate the fold level (less folds)
	"zv expand folds to reveal cursor
	"zx Recompute folds
	"zf Creates manual folder. E.g in html use zfat,zit to fold to the end tag
	nnoremap , za
	nnoremap <leader>, zMzv
	set foldlevelstart=0 " start file with all folds close
" }}}

"Vimscript file setting ----- {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

"lua file setting ----- {{{
augroup filetype_lua
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" xml {{{
	let g:xml_syntax_folding=1
	au FileType xml setlocal foldmethod=syntax
" }}}
"
" json {{{
	au FileType json setlocal foldmethod=syntax
" }}}

	"Searching {{{
	set wildmode=longest,list "search by files completing like sh
	set path+=** "allow searching in subdirectories
	set hlsearch " hilight searched term
	set smartcase "only applies when ignorecase is set
	set ignorecase 
	set smartindent
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
	set nobackup "Remove backup files swp
	set hidden "Allow exit buffer without saving
	set scrolloff=5 " Always show 5 lines between current cursor line and top or bottom line
  set sidescrolloff=5
	set number
	set cursorline
  set signcolumn=yes:1
	
	map gf :edit <cfile><cr> "Allow gf to open non-" existing files
	"}}}
	
	"Navigating quick list{{{
	nnoremap <Up> :cprevious<cr>
	nnoremap <Down> :cnext<cr>
	nnoremap <Left> :cpf<cr>
	nnoremap <Right> :cnf<cr>
	"}}}

	"Cursorline{{{
  set cursorline   "highlight the current line
	"}}}
	
	"split lines{{{
	"removes vertical line on split 
  set fillchars+=vert:\  
	"}}}

	"Status Line {{{
	set laststatus=3 "Display only one status line at the bottom
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
	if !has ('nvim')
		set ttymouse=sgr
	endif
	" }}}

	"KeyBindings{{{
	let mapleader="\<Space>"
	:inoremap jk <Esc>
	noremap ; :
	"delete a buffer without exiting window
	nnoremap \d :bp<cr>:bd! #<cr>
	" <leader>-c redraws the screen and removes any search highlighting.
	nnoremap <silent> <Leader>c :nohl<CR><C-l>
	"change pwd to current parent folder
	nnoremap cd. :lcd %:p:h<CR>:pwd<CR>
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

"Other options{{{
set splitright "force all horizontal splits to go below current window
set splitbelow  "force all horizontal splits to go below current window
se noswapfile
set undofile "persistent save
set tabstop=2 shiftwidth=2 softtabstop=2 "generic tabwidth
let g:netrw_browsex_viewer="cmd.exe /C start" "for gx to work on WSL 
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
					echon ' tabstop='.&l:ts
					echon ' shiftwidth='.&l:sw
					echon ' softtabstop='.&l:sts
					set expandtab?
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
	nnoremap <Leader>ma :e ~/.dailyhours.md<CR> "track daily hours
	nnoremap <Leader>wc :e /mnt/c/wfo/components/<CR> "take me to main wfo compo
	nnoremap <Leader>wp :e /mnt/c/wfo/projects/<CR> "take me to main wfo compo
"}}}

" Shorcuts EM Session logs{{{
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

" Resize with arrows{{{
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
"}}}

"Custom commmands, e.g BufOnly{{{
command! BufOnly execute '%bdelete|edit #|normal `"'
"}}}

function! Redir(cmd)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let output = system(matchstr(a:cmd, '^!\zs.*'))
  else
    redir => output
    execute a:cmd
    redir END
  endif
  botright vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, split(output, "\n"))
endfunction
"`:Redir` followed by either shell or vim command
command! -nargs=+ -complete=command Redir silent call Redir(<q-args>)
