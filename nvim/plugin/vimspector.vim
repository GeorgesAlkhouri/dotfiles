" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>dc <Plug>VimspectorRunToCursor
nmap <leader>dp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcp <Plug>VimspectorToggleConditionalBreakpoint

let g:vimspector_base_dir = expand( '$HOME/.config/nvim/vimspector' )
let g:vimspector_enable_mappings = 'HUMAN'
