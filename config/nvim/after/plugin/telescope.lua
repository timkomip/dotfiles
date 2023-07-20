local builtin = require('telescope.builtin')
local wk = require("which-key")

-- WIP
-- wk.register({ "\\" = { builtin.live_grep, "Find Text" }})
-- wk.register({
--   f = {
--     name = "Find...",
--     f = { "<cmd>builtin.find_files<cr>", "Find Files" },
--     g = { "<cmd>builtin.git_files<cr>", "Find Git Files" },
--     b = { "<cmd>builtin.buffers<cr>", "Find Buffers" },
--     h = { "<cmd>builtin.help_tags<cr>", "Find Vim Help" },
--     t = { "<cmd>builtin.tags<cr>", "Find Tags" },
--     r = { "<cmd>builtin.oldfiles<cr>", "Find Recent" },
--   },
-- }, { prefix = "<leader>" })

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
