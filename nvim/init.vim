let g:mapleader = "\\"

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap zx :NERDTreeToggle<CR>


" switch buffer in terminal mode
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

let g:deoplete#enable_at_startup = 1

let g:polyglot_disabled = ['python']

"" semshi
let g:semshi#mark_selected_nodes=1
let g:semshi#error_sign=v:false

"" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

"" Nerdtree
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapUpdir = 'H'
let g:NERDTreeMapChangeRoot = 'L'

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

" Fileype settings

autocmd FileType python
       \ call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab

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
" Debugger
Plug 'puremourning/vimspector', { 'do' : './install_gadget.py --basedir ~/.config/nvim/vimspector --enable-python'}
" Docstrings
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
call plug#end()


" Python 3 Provider
let g:python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'


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
