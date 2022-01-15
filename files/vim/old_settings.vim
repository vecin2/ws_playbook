	"Clipboard settings {{{
	"Allows to paste text copied from Vim after exit vim
	autocmd VimLeave * call system("xclip -o | xclip -selection c")
	"}}}
  
	"Navigating docs {{{
	"This map allows to use the arrow keys in insert mode. Otherwise it shows
	"strange characters
	map OA <up>
	map OB <down>
	map OC <right>
	map OD <left>
	map gf :edit <cfile><cr>
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

" Javascript {{{
	au FileType javascript,typescript,json setlocal foldmarker={,} foldmethod=marker
	au FileType javascript,typescript,json syntax region bracketFold start="\[" end="\]" transparent fold
" }}}
"
"
"
"
"Plugins{{{

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

"}}}
