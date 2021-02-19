local lsp = {}
local nvim_lsp = require'lspconfig'


local filetypes = {'python'}


vim.cmd [[augroup vimrc_lsp]]
  vim.cmd [[autocmd!]]
  vim.cmd(string.format('autocmd FileType %s call v:lua.scope.lsp.setup()', table.concat(filetypes, ',')))
vim.cmd [[augroup END]]


function lsp.setup()
  vim.cmd[[autocmd CursorHold <buffer> silent! lua require"lspsaga.diagnostic".show_line_diagnostics()]]
   vim.cmd[[autocmd CursorHoldI <buffer> silent! lua require('lspsaga.signaturehelp').signature_help()]]
end

require'lspsaga'.init_lsp_saga({
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
})


nvim_lsp.pyls.setup{}

_G.scope.lsp = lsp
