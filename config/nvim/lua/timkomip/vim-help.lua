local group = vim.api.nvim_create_augroup('vimhelp', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  group = group,
  command = 'nnoremap <buffer> q :q<CR>' -- x
})
