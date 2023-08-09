local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local builtin = require('telescope.builtin')
local lspconfig = require('lspconfig')

-- local cmp_action = require('lsp-zero').cmp_action()

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'solargraph',
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
lsp.setup()
cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

-- lsp.format_on_save({
--   format_opts = {
--     async = false,
--     timeout_ms = 10000,
--   },
--   servers = {
--     ['lua_ls'] = { 'lua' },
--     ['standardrb'] = { 'ruby' },
--     -- if you have a working setup with null-ls
--     -- you can specify filetypes it can format.
--     -- ['null-ls'] = {'javascript', 'typescript'},
--   }
-- })

-- (Optional) Configure lua language server for neovim

-- You need to setup `cmp` after lsp-zero
