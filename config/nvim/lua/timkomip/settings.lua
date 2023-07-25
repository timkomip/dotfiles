vim.opt.wrap = false
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.linespace = 2
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.switchbuf= "useopen"
vim.opt.mouse= "a"
vim.opt.autowrite = true

-- fix splits (ugh)
vim.opt.splitbelow = true
vim.opt.splitright = true

-- 2 space indents rule!
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- line numbers
vim.opt.relativenumber = true

-- scroll
vim.opt.scrolloff=5

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- shell
vim.opt.shell = 'zsh'

-- ctags
vim.opt.tags = "./tags,tags"
