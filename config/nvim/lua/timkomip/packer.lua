vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' }
    } --,
    -- config = function()
    --   require("telescope").load_extension("live_grep_args")
    -- end
  }
  -- use({
  --   'rose-pine/neovim',
  --   as = 'rose-pine',
  --   config = function()
  --     vim.cmd('colorscheme rose-pine')
  --   end
  -- })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('tpope/vim-surround')
  use('tpope/vim-commentary')
  use('tpope/vim-rails')
  use('vim-ruby/vim-ruby')

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                            -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    },
  }
  use('voldikss/vim-floaterm')
  use("vim-test/vim-test")
  use("tpope/vim-bundler")
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
  use({
    "arsham/arshamiser.nvim",
    requires = {
      "arsham/arshlib.nvim",
      "famiu/feline.nvim",
      "rebelot/heirline.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      -- ignore any parts you don't want to use
      vim.cmd.colorscheme("arshamiser_light")
      require("arshamiser.feliniser")
      -- or:
      -- require("arshamiser.heirliniser")

      _G.custom_foldtext = require("arshamiser.folding").foldtext
      vim.opt.foldtext = "v:lua.custom_foldtext()"
      -- if you want to draw a tabline:
      vim.api.nvim_set_option("tabline", [[%{%v:lua.require("arshamiser.tabline").draw()%}]])
    end,
  })
  use("jremmen/vim-ripgrep")
end)
