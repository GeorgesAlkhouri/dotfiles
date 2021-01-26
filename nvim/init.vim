let g:mapleader = "\\"

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <leader>sv :source $MYVIMRC<CR>

"let g:deoplete#enable_at_startup = 1

"" semshi
let g:semshi#mark_selected_nodes=1
let g:semshi#error_sign=v:false

"" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

"" ale
let g:ale_completion_enabled = 0
let g:ale_virtualtext_cursor = 1
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_info = ''
let g:ale_use_global_executables = 0
" Use global executables as fallback if not found in pyenv
let g:ale_python_flake8_executable= $HOME . '/.pyenv/versions/pynvim/bin/flake8'
let g:ale_python_mypy_executable= $HOME . '/.pyenv/versions/pynvim/bin/mypy'
"let g:ale_python_pyls_executable= $HOME . '/.pyenv/versions/pynvim/bin/pyls'
let g:ale_python_pylint_executable= $HOME . '/.pyenv/versions/pynvim/bin/pylint'
let g:ale_python_isort_executable = $HOME . '/.pyenv/versions/pynvim/bin/isort'
let g:ale_python_yapf_executable = $HOME . '/.pyenv/versions/pynvim/bin/yapf'



let g:ale_linters = {
            \   'gitcommit': ['gitlint'],
            \   'python': ['flake8', 'mypy', 'pylint'],
            \   'sh': ['shellcheck', 'bashate'],
            \   'sql': ['sqlint'],
            \   'markdown': ['markdownlint'],
            \   'vim': ['vint'],
            \   'zsh': ['shellcheck'],
            \}

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'markdown': ['prettier'],
            \   'python': ['yapf', 'isort'],
            \   'sh': ['shfmt'],
            \   'sql': ['pgformatter'],
            \}
"" Nerdtree
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapUpdir = 'H'
let g:NERDTreeMapChangeRoot = 'L'
let g:NERDTreeMapToggle = 'z'

filetype plugin indent on
syntax on
set number
set clipboard=unnamedplus
set cursorline
set completeopt=menuone,noinsert,noselect
" A buffer becomes hidden when it is abandoned
set hidden
" Ignore case when searching
set ignorecase

call plug#begin('~/.local/share/nvim/plugged')


Plug 'preservim/nerdcommenter'

" Language Serve Plugins
Plug 'neovim/nvim-lspconfig'
"" Autocomplete
Plug 'nvim-lua/completion-nvim'
"Plug 'Shougo/deoplete.nvim'
"Plug 'Shougo/deoplete-lsp'
"Plug 'lighttiger2505/deoplete-vim-lsp'
"Supertab to fill Autocomplete
"Plug 'ervandew/supertab'
" Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
" Pair edit with Brackets
Plug 'jiangmiao/auto-pairs'
"" Linting
Plug 'dense-analysis/ale'
"" Snytax
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Indent
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'sheerun/vim-polyglot'
" Color Scheme
" Navigation
Plug 'preservim/nerdtree'
call plug#end()


" Python 3 Provider
let g:python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'

:lua << EOF
  vim.lsp.set_log_level("debug")
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require('completion').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    --if client.resolved_capabilities.document_formatting then
    --    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --elseif client.resolved_capabilities.document_range_formatting then
    --    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --end

  end

  nvim_lsp['pyls'].setup{on_attach=on_attach, cmd={os.getenv("HOME") .. '/.pyenv/versions/pynvim/bin/pyls'}}

EOF

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
