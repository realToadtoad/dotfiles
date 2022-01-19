-- allows completion overlay to work
vim.opt.completeopt = "menuone,noselect"

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
local omnisharp_bin = (vim.fn.has("win32") == 1) and [[C:\ProgramData\chocolatey\lib\omnisharp\tools\OmniSharp.exe]] or "/usr/bin/omnisharp"; -- add windows path next time i use windows
nvim_lsp.omnisharp.setup({
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
  on_attach = function(client)
    require('lsp_signature').on_attach()
  end
})
nvim_lsp.texlab.setup({
  on_attach = function(client)
    require('lsp_signature').on_attach()
  end
})
require'lspconfig'.jdtls.setup{
  on_attach = function(client)
    require('lsp_signature').on_attach()
  end
}

-- completion plugin
require('cmp').setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" }
  }
})
