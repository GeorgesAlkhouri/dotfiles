local plugins = {}
local api = vim.api

vim.cmd [[packadd vim-packager]]

require('packager').setup(function(packager)
  packager.add('neovim/nvim-lspconfig')
end)

_G.scope.plugins = plugins
