vim.api.nvim_create_user_command('SPS', function(opts) 
    vim.cmd('so ~/.config/nvim/lua/timkomip/packer.lua')
    vim.cmd('PackerSync')
  end,
  { nargs = 0})

