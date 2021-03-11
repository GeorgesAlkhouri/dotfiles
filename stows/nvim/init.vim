let g:mapleader = "\\"

filetype plugin indent on
syntax on
set smarttab
set number
set clipboard=unnamedplus
set cursorline
set completeopt=menuone,noinsert,noselect
" A buffer becomes hidden when it is abandoned
set hidden
" Ignore case when searching
set ignorecase

" Python 3 Provider
let g:python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'

let g:deoplete#enable_at_startup = 1

let g:polyglot_disabled = ['python']

let g:pydocstring_formatter = 'numpy'

"" semshi
let g:semshi#mark_selected_nodes=1
let g:semshi#error_sign=v:false

"" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

call plug#begin('~/.local/share/nvim/plugged')

" Comments
Plug 'preservim/nerdcommenter'
" Language Serve Plugins
Plug 'neovim/nvim-lspconfig'
"" Autocomplete
Plug 'nvim-lua/completion-nvim'
Plug 'Shougo/deoplete.nvim'
"Plug 'Shougo/deoplete-lsp'
" Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Color Scheme
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sheerun/vim-polyglot'
" Pair edit with Brackets
Plug 'jiangmiao/auto-pairs'
"" Linting
Plug 'dense-analysis/ale'
"" Snytax
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Indent
Plug 'Vimjas/vim-python-pep8-indent'
" Navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Debugger
Plug 'puremourning/vimspector', { 'do' : './install_gadget.py --basedir ~/.config/nvim/vimspector --all --force-all --enable-python'}
" Docstrings
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'wookayin/vim-autoimport'
" Tagbar
Plug 'preservim/tagbar'
call plug#end()

if $TERM =~ '^\(rxvt\|screen\|interix\|putty\)\(-.*\)\?$'
                set notermguicolors
elseif $TERM =~ '^\(tmux\|iterm\|vte\|gnome\)\(-.*\)\?$'
    set termguicolors
elseif $TERM =~ '^\(xterm\)\(-.*\)\?$'
    if $XTERM_VERSION != ''
                set termguicolors
    elseif $KONSOLE_PROFILE_NAME != ''
        set termguicolors
    elseif $VTE_VERSION != ''
        set termguicolors
    else
       set notermguicolors
     endif
 endif


colorscheme gruvbox
let g:airline_theme='gruvbox'
