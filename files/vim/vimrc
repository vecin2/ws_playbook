set nocompatible              " be iMproved, required
syntax enable
filetype plugin indent on

"bundle Plugins {{{
set rtp+=~/.vim/bundle/Vundle.vim,~/.fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"
"UI and utils{{{
Plugin 'chriskempson/base16-vim'
Plugin 'https://github.com/lisposter/vim-blackboard.git' "allows window highlighting
Plugin 'sonph/onehalf', {'rtp':'vim/'}
Plugin 'sickill/vim-monokai'
Plugin 'https://github.com/29decibel/codeschool-vim-theme.git'
Plugin 'lifepillar/vim-solarized8'
Plugin 'arcticicestudio/nord-vim'
Plugin 'morhetz/gruvbox'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'https://github.com/blueyed/vim-diminactive'

"Shorcut commmands, e.g: resize window quicker
Plugin 'https://github.com/kana/vim-arpeggio.git'
Plugin 'https://github.com/kana/vim-submode.git'
Plugin 'git@github.com:tpope/vim-unimpaired.git'
"}}}

"Search && Navigation {{{
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/ivalkeen/nerdtree-execute.git'
"This pull request from syntastic fixes an issue when opening files
"out of nerdtree, e.g fzf and then try to save then
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'https://github.com/terryma/vim-smooth-scroll'
"Plugin 'https://github.com/easymotion/vim-easymotion.git'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'https://github.com/tpope/vim-projectionist.git'
Plugin 'https://github.com/mileszs/ack.vim.git'
Plugin 'https://github.com/bronson/vim-visual-star-search.git'
"Interact with tmux (VimRunLasCommand)
"Plugin 'https://github.com/benmills/vimux.git'
"}}}

"Editing{{{
Plugin 'https://github.com/tpope/vim-repeat.git'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'jiangmiao/auto-pairs'
Plugin 'https://github.com/tommcdo/vim-exchange.git'
"Dealing with swap files
Plugin 'https://github.com/gioele/vim-autoswap'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
"}}}

"Dev plugins{{{
"Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'https://github.com/tpope/vim-endwise.git'
Plugin 'https://github.com/vim-ruby/vim-ruby.git'
Plugin 'alfredodeza/pytest.vim'
Plugin 'tpope/vim-fugitive'
"Bundle 'skalnik/vim-vroom'
Plugin 'https://github.com/tpope/vim-dispatch.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'tmhedberg/SimpylFold' "folds for python
"Plugin 'Python-Syntax-Folding'
"Plugin 'kalekundert/vim-coiled-snake'
"Plugin 'Konfekt/FastFold' "it is recommended for performance if vim-coiled-snake is install

"PYTHON IDE
Plugin 'dense-analysis/ale' "Asynchronous Ling Engine
Plugin 'https://github.com/python-rope/ropevim.git' "refactoring
"}}}
 " Brief help
 " :PluginList       - lists configured plugins
 " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
 " :PluginSearch foo - searches for foo; append `!` to refresh local cache
 " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

 " see :h vundle for more details or wiki for FAQ
call vundle#end()
"}}}


"colorscheme gruvbox
" Source vim config when save {{{
augroup sourcevim
	autocmd!
	autocmd bufwritepost vimrc,config.vim,plugins.vim source $MYVIMRC
augroup END

" }}}
so ~/.vim/config.vim
so ~/.vim/plugins.vim
