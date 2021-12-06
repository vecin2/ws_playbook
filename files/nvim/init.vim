set nocompatible              " be iMproved, required
syntax enable
filetype plugin indent on
set rtp+=~/.fzf

"Plug autoinstall{{{
let data_dir = '~/.config/nvim/'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"Plugs {{{

call plug#begin('~/.config/nvim/plugged')

"
"UI and utils{{{
Plug 'chriskempson/base16-vim'
Plug 'https://github.com/lisposter/vim-blackboard.git' "allows window highlighting
Plug 'sonph/onehalf', {'rtp':'vim/'}
Plug 'sickill/vim-monokai'
Plug 'https://github.com/29decibel/codeschool-vim-theme.git'
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'https://github.com/blueyed/vim-diminactive'

"Shorcut commmands, e.g: resize window quicker
Plug 'https://github.com/kana/vim-arpeggio.git'
Plug 'https://github.com/kana/vim-submode.git'
Plug 'https://tpope.io/vim/unimpaired.git'
"}}}

"Search && Navigation {{{
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/ivalkeen/nerdtree-execute.git'
"This pull request from syntastic fixes an issue when opening files
"out of nerdtree, e.g fzf and then try to save then
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/terryma/vim-smooth-scroll'
"Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'https://github.com/tpope/vim-projectionist.git'
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'https://github.com/bronson/vim-visual-star-search.git'
"Interact with tmux (VimRunLasCommand)
"Plug 'https://github.com/benmills/vimux.git'
"}}}

"Editing{{{
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'jiangmiao/auto-pairs'
Plug 'https://github.com/tommcdo/vim-exchange.git'
"Dealing with swap files
Plug 'https://github.com/gioele/vim-autoswap'
" Snippets are separated from the engine. Add this if you want them:
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'


"Dev plugins{{{
Plug 'neovim/nvim-lspconfig'
"Autocompletion cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'


" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"{{{ Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
"}}}
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/vim-ruby/vim-ruby.git'
Plug 'alfredodeza/pytest.vim'
Plug 'tpope/vim-fugitive'
"Bundle 'skalnik/vim-vroom'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/ervandew/supertab.git'

"{{{Python
Plug 'dense-analysis/ale' "Asynchronous Ling Engine
Plug 'https://github.com/python-rope/ropevim.git' "refactoring
Plug 'tmhedberg/SimpylFold' "folds for python
Plug 'ray-x/lsp_signature.nvim' "hint when invoking function
"}}}
"}}}
call plug#end()
"}}}
"}}}
" Source vim config when save {{{
augroup sourcevim
	autocmd!
	autocmd bufwritepost vimrc,config.vim,plugins.vim source $MYVIMRC
augroup END

" }}}

so ~/.vim/config.vim
so ~/.vim/plugins.vim

"{{{cmp
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

EOF
"}}}
"{{{ lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
		capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
"}}}
"{{{lsp-signature
lua << EOF
require "lsp_signature".setup()
EOF
"}}}
