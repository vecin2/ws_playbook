"Arpeggio initialization {{{
call arpeggio#load()
" }}}

"FZF shorcuts +Ack with AG {{{

"Ag searches only by content not by filename
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
"shorcuts
nnoremap <leader>g :Ag<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <Leader>t :Files<CR>
nnoremap <Leader>r :History:<CR>
""
""Search in project for word under the test
Arpeggiomap aj <leader>ag
"perform linewise completition based on what you’ve already typed
imap <c-x><c-l> <plug>(fzf-complete-line)

" Redefine :Ag command
"autocmd VimEnter * command! -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path "33;1"', fzf#vim#default_layout)
"set t_ZH=[3m
"set t_ZR=[23m
"set termguicolors

"}}}

"Syntasic {{{
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
""Solve error when sourcing files in bash files
"let g:syntastic_sh_shellcheck_args = "-x"
"
"let g:syntastic_mode_map = {
"    \ "mode": "active",
"    \ "passive_filetypes": ["xml","java","sh"] }

"workaround to fix draw issue with syntastic
"augroup redrawfix
"	autocmd!
"	autocmd VimEnter * nnoremap <silent> <c-j> :TmuxNavigateDown<cr>:redraw!<cr>
"augroup END

"}}}

"YouCompleteMe (ycm){{{
"Uncomment this if it prompts for confirmaiton to load the extra conf python
"file
"let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 0
noremap gt :YcmCompleter GoToDefinition<CR>zv
"}}}

"Vimux {{{
noremap <Leader>vp :VimuxPromptCommand<CR>
noremap <Leader>vl :VimuxRunLastCommand<CR>
noremap <Leader>vi :VimuxInspectRunner<CR>
noremap <Leader>vz :VimuxZoomRunner<CR>
Arpeggiomap vl <leader>vl
"}}}

"Scroll smooth{{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
"}}}

"NerdTree{{{
"Runs NT when no folder or file specified
augroup nerdtree
	"Close NT is the only window left is NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

"Use Arpeggio
Arpeggiomap bd \d
nnoremap <Leader>v :NERDTreeToggle<Enter>
nnoremap <Leader>f :NERDTreeFind<Enter>
let NERDTreeAutoDeleteBuffer = 1 "Automatically delete a buffer when delete file from NT
let g:NERDTreeQuitOnOpen = 1 "Closes nerdtree when opening a file

"Hide Press ? for help
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['.pyc$']

"}}}

"Submodules{{{
" don't consume submode-leaving key
let g:submode_keep_leaving_key = 1
let g:submode_always_show_submode = 1

"Allows changin windows size easily
call submode#enter_with('window', 'n', '', '<C-w>')
for key in ['a','b','c','d','e','f','g','h','i','j','k','l','m',
\           'n','o','p','q','r','s','t','u','v','w','x','y','z','-']
  " maps lowercase, uppercase and <C-key>
  call submode#map('window', 'n', '', key, '<C-w>' . key)
  call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
  call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
endfor
for key in ['=','_','+','-','<','>','w']
  call submode#map('window', 'n', '', key, '<C-w>' . key)
endfor

call submode#enter_with('goToFoldDown', 'n', '', 'zj')
call submode#map('goToFoldDown', 'n', '', 'j', 'zj')
call submode#map('goToFoldDown', 'n', '', 'k', 'zk')
call submode#enter_with('goToFoldUp', 'n', '', 'zk')
call submode#map('goToFoldUp', 'n', '', 'k', 'zk')
call submode#map('goToFoldUp', 'n', '', 'j', 'zj')

"}}}

"Ultisnips {{{
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsExpandTrigger="<c-f>"
"let g:UltiSnipsJumpForwardTrigger="<c-f>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"}}}

"ale {{{
let g:ale_linters ={'python':['flake8']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python':['add_blank_lines_for_python_control_statements','black','isort']
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
"let g:ale_sign_error = '●'
"let g:ale_sign_warning = '.'

noremap ]a :ALENextWrap<CR>
noremap [a :ALEPreviousWrap<CR>
noremap ]A :ALELast<CR>
noremap [A :ALEFirst<CR>

highlight ALEError ctermbg=DarkRed
highlight ALEError guibg=DarkRed
highlight ALEWarning guibg=Yellow
"}}}

"{{{Pytest
nmap <silent><Leader>pf <Esc>:Pytest file<CR>
nmap <silent><Leader>pc <Esc>:Pytest class<CR>
nmap <silent><Leader>pm <Esc>:Pytest method<CR>
nmap <silent><Leader>pp <Esc>:Pytest project<CR>
nmap <silent><Leader>ps <Esc>:Pytest session<CR>
Arpeggiomap tp <leader>pp
let g:pytest_test_dir='/home/dgarcia/dev/python/python-emtask'
"}}}
