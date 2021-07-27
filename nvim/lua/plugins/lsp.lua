-- allows completion overlay to work
vim.opt.completeopt = {'menuone', 'noselect'}

-- prevents warnings from showing all the time
vim.opt.shortmess = vim.opt.shortmess + 'c'

-- lsp config
require('lspconfig').tsserver.setup({
  on_attach = function(client)
    require('lsp_signature').on_attach()
  end
})

-- completion plugin
require('compe').setup({
  enabled = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
  }
})
