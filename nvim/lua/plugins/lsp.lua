-- allows completion overlay to work
vim.opt.completeopt = "menuone,noselect"

-- prevents warnings from showing all the time
vim.opt.shortmess = vim.opt.shortmess + 'c'

-- lsp config
local bufopts = { noremap=true, silent=true, buffer=bufnr }
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
  -- enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- mappings
  -- see `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  require('lsp_signature').on_attach()
end

-- javascript / typescript
nvim_lsp.tsserver.setup({ on_attach = on_attach })
-- c#
local pid = vim.fn.getpid();
local omnisharp_bin = (vim.fn.has("win32") == 1) and [[C:\ProgramData\chocolatey\lib\omnisharp\tools\OmniSharp.exe]] or "/usr/bin/omnisharp"; -- add windows path next time i use windows
nvim_lsp.omnisharp.setup({
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
  on_attach = on_attach
})
-- latex
nvim_lsp.texlab.setup({ on_attach = on_attach })
-- java
nvim_lsp.jdtls.setup({
  cmd = { "jdtls" };
  on_attach = on_attach;
})
-- svelte
nvim_lsp.svelte.setup({ on_attach = on_attach })
-- racket
nvim_lsp.racket_langserver.setup({ on_attach = on_attach })
-- python
nvim_lsp.jedi_language_server.setup({ on_attach = on_attach })

-- format plugin
local util = require "formatter.util"
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    -- lua = {
    --   -- "formatter.filetypes.lua" defines default configurations for the
    --   -- "lua" filetype
    --   require("formatter.filetypes.lua").stylua,
    -- },
    javascript = {
      require("formatter.filetypes.javascript").prettier
    },
    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettier
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier
    },
    typescriptreact = {
      require("formatter.filetypes.typescriptreact").prettier
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      -- require("formatter.filetypes.any").remove_trailing_whitespace
      -- vim.lsp.buf.formatting
    }
  }
}

-- completion plugin
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({
      select = true
    }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" }
  }
})
