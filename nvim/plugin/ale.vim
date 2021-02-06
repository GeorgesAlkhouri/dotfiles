scriptencoding utf-8

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
let g:ale_python_black_executable = $HOME . '/.pyenv/versions/pynvim/bin/black'
let g:ale_vim_vint_executable = $HOME . '/.pyenv/versions/pynvim/bin/vint'
let g:ale_yaml_yamlfix_executable = $HOME . '/.pyenv/versions/pynvim/bin/yamllint'

let g:pydocstring_formatter = 'numpy'

let g:ale_linters = {
            \   'gitcommit': ['gitlint'],
            \   'python': ['flake8', 'mypy', 'pylint'],
            \   'sh': ['shellcheck', 'bashate'],
            \   'sql': ['sqlint'],
            \   'markdown': ['markdownlint'],
            \   'vim': ['vint'],
            \   'zsh': ['shellcheck'],
						\   'yaml': ['yamllint']
            \}

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'markdown': ['prettier'],
            \   'python': ['black', 'isort'],
            \   'sh': ['shfmt'],
            \   'sql': ['pgformatter'],
						\   'yaml': ['prettier']
            \}
