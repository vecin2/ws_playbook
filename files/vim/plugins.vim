"Vimux {{{
noremap <Leader>vp :VimuxPromptCommand<CR>
noremap <Leader>vl :VimuxRunLastCommand<CR>
noremap <Leader>vi :VimuxInspectRunner<CR>
noremap <Leader>vz :VimuxZoomRunner<CR>

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


nnoremap <Leader>f :NERDTreeFind<Enter>
let NERDTreeAutoDeleteBuffer = 1 "Automatically delete a buffer when delete file from NT
let g:NERDTreeQuitOnOpen = 1 "Closes nerdtree when opening a file

"Hide Press ? for help
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['.pyc$']

"}}}

"{{{Pytest
nmap <silent><Leader>pf <Esc>:Pytest file<CR>
nmap <silent><Leader>pc <Esc>:Pytest class<CR>
nmap <silent><Leader>pm <Esc>:Pytest method<CR>
nmap <silent><Leader>pp <Esc>:Pytest project<CR>
nmap <silent><Leader>ps <Esc>:Pytest session<CR>

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


