"Arpeggio initialization {{{
call arpeggio#load()
" }}}

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
"nnoremap <Leader>v :NERDTreeToggle<Enter>
nnoremap <Leader>v :NERDTreeFind<Enter>
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

"{{{Pytest
nmap <silent><Leader>pf <Esc>:Pytest file<CR>
nmap <silent><Leader>pc <Esc>:Pytest class<CR>
nmap <silent><Leader>pm <Esc>:Pytest method<CR>
nmap <silent><Leader>pp <Esc>:Pytest project<CR>
nmap <silent><Leader>ps <Esc>:Pytest session<CR>
Arpeggiomap tp <leader>pp
let g:pytest_test_dir='/home/dgarcia/dev/python/python-emtask'
"}}}

""ale {{{
"let g:ale_linters ={'python':['flake8'], 'yaml':['yamllint']}
"let g:ale_fixers = {
"\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'javascript': ['eslint'],
"\		'yaml':['yamlfix'],
"\   'python':['add_blank_lines_for_python_control_statements','black','isort']
"\}
"let g:ale_fix_on_save = 1
"let g:ale_lint_on_enter = 0
""let g:ale_sign_error = '●'
""let g:ale_sign_warning = '.'
"let g:ale_yaml_yamllint_options='-d relaxed'
"
"noremap ]a :ALENextWrap<CR>
"noremap [a :ALEPreviousWrap<CR>
"noremap ]A :ALELast<CR>
"noremap [A :ALEFirst<CR>
"
"highlight ALEError ctermbg=DarkRed
"highlight ALEError guibg=DarkRed
"highlight ALEWarning guibg=Yellow
""}}}


