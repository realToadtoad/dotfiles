-- allows completion overlay to work
vim.opt.completeopt = {'menuone', 'noselect'}

-- prevents warnings from showing all the time
vim.opt.shortmess = vim.opt.shortmess + 'c'

-- lsp config
local nvim_lsp = require("lspconfig")
nvim_lsp.tsserver.setup({
  on_attach = function(client)
    require('lsp_signature').on_attach()
  end
})
local pid = vim.fn.getpid();
local omnisharp_bin = (vim.fn.has("win32") == 1) and "" or "/usr/bin/omnisharp"; -- add windows path next time i use windows
nvim_lsp.omnisharp.setup({
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
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
