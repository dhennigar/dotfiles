-- Basics
vim.opt.autoindent = true
vim.opt.cursorline = true

-- Plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'navarasu/onedark.nvim'
Plug 'jalvesaq/Nvim-R'

vim.call('plug#end')

-- Colors
-- require('onedark').setup {
-- 	style = 'darker'
-- }
require('onedark').load()
