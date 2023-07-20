local builtin = require('telescope.builtin')

-- find file
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- find git (files)
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

-- find everywhere
vim.keymap.set('n', '\\', builtin.live_grep, {})

-- find buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- find help
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- find tags
vim.keymap.set('n', '<leader>ft', builtin.tags, {})

-- find recent
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
