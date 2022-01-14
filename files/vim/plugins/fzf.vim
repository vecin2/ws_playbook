"Ag searches only by content not by filename
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore logs',{'options': '--delimiter : --nth 4..'}, <bang>0)

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

"Customize  colors to match your color scheme
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

