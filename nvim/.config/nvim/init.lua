-- Basics
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.g.mapleader = ','
vim.g.maplocalleader = ';'

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

-- Nvim-R
vim.cmd([[
let R_auto_start = 1
let R_objbr_auto_start = 1
let R_objbr_place = 'console,above'
let R_assign_map = '<M-->'
]])
