-- set mapleader
vim.g.mapleader = ";"

-- copy and paste to clipboard
vim.api.nvim_set_keymap('', '<Leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('', '<Leader>p', '"+p', {noremap = true})
vim.api.nvim_set_keymap('', '<Leader>P', '"+P', {noremap = true})
vim.api.nvim_set_keymap('', '<Leader>d', '"+d', {noremap = true})

-- auto-indent
vim.api.nvim_set_keymap('', '<Leader>=', 'mqHmwgg=G`wzt`q', {noremap = true})

-- change directory to current
vim.api.nvim_set_keymap('n', '<Leader>cd', ':cd %:p:h<CR>:pwd<CR>', {noremap = true})
