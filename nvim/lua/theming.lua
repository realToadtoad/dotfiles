-- set true colors
vim.opt.termguicolors = true

-- set theme
require("tokyonight").setup({
  style = "night"
})
vim.cmd[[colorscheme tokyonight]]
lualine_theme = 'tokyonight'

-- set font
vim.opt.guifont = 'VictorMono Nerd Font:h10'
-- vim.opt.guifont = 'Victor Mono'
