set nocompatible
set termguicolors

let g:ale_disable_lsp = 1

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
call plug#end()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:lightline = {'colorscheme' : 'tokyonight'}

colorscheme tokyonight
set guifont=Victor\ Mono:h11
set number
set noshowmode
