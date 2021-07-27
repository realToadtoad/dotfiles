set nocompatible
set termguicolors

set mouse=a

set completeopt=menuone,noselect
set shortmess+=c

set tabstop=2
set shiftwidth=2
set expandtab

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'yamatsum/nvim-nonicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua << EOF
require'lspconfig'.tsserver.setup{
  on_attach = function(client)
    require'lsp_signature'.on_attach()
  end
}

require'nvim-autopairs'.setup({
  check_ts = true,
  ts_config = {},
  enable_check_bracket_line = true,
  ignored_next_char = "[%w%.]",
})
require'nvim-autopairs.completion.compe'.setup({
  map_cr = true,
  map_complete = true
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  autopairs = {
    enable = true
  },
  autotag = {
    enable = true
  }
}

  require'nvim-web-devicons'.setup()

  require'nvim-nonicons'.get("file")

  require('lualine').setup({
    options = {
      theme = 'tokyonight'
    }
  })
EOF

let mapleader = ";"
nnoremap <leader>v <cmd>CHADopen<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>d "+d
noremap <leader>= ggVG=<C-o>


let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

" let g:chadtree_settings = { "theme.icon_glyph_set": "ascii" }

silent! colorscheme tokyonight
" silent! colorscheme spaceduck
" set guifont=JetBrains\ Mono\ Nerd\ Font\ Mono:h12

set guifont=VictorMono\ Nerd\ Font
set number
set noshowmode
