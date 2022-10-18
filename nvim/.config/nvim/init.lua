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
Plug 'RRethy/nvim-base16'
Plug 'jalvesaq/Nvim-R'

vim.call('plug#end')

-- Colors
vim.cmd([[
if has('termguicolors')
	set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256          " Remove this line if not necessary
  source ~/.vimrc_background
endif

]])

-- Nvim-R
vim.cmd([[
let R_auto_start = 1
let R_min_editor_width = 40
let R_rconsole_width = winwidth(0) / 2
autocmd VimResized * let R_rconsole_width = winwidth(0) / 2
let R_objbr_auto_start = 1
let R_objbr_place = 'console,above'
let R_assign_map = '<M-->'
let R_nvim_wd = 1
]])
