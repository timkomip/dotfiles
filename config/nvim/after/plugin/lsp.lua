local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local builtin = require('telescope.builtin')
local lspconfig = require('lspconfig')

-- local cmp_action = require('lsp-zero').cmp_action()

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'standardrb'
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  -- format
  vim.keymap.set({ 'n', 'x' }, '<leader>fm', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, { buffer = bufnr })


  vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = true })
  vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { buffer = true })
end)

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.solargraph.setup({
  init_options = { formatting = false },
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
})

lsp.setup()

-- cmp.setup({
--   mapping = {
--     -- `Enter` key to confirm completion
--     ['<CR>'] = cmp.mapping.confirm({ select = false }),

--     -- Ctrl+Space to trigger completion menu
--     ['<C-Space>'] = cmp.mapping.complete(),
--   }
-- })

