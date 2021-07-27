require('packer').startup(function()
  -- packer
  use 'wbthomason/packer.nvim'

  -- dependencies
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- theming / customization
  use 'folke/tokyonight.nvim'
  use {'yamatsum/nvim-nonicons', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'hoob3rt/lualine.nvim'

  -- filesystem navigation
  use 'nvim-telescope/telescope.nvim'
  use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'

  -- treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'windwp/nvim-ts-autotag'
  
  -- text editing
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use {'easymotion/vim-easymotion', cond = vim.api.nvim_eval('!exists("g:vscode")')} -- load different easymotion depending on if using nvim or vscode nvim plugin
  use {'asvetliakov/vim-easymotion', cond = vim.api.nvim_eval('exists("g:vscode")'), as = 'vsc-easymotion'}
  use 'windwp/nvim-autopairs'

end)

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
