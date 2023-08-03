local telescope = require("telescope")
local builtin = require('telescope.builtin')
local extensions = require("telescope").extensions
local lga_actions = require("telescope-live-grep-args.actions")

telescope.load_extension("live_grep_args")

telescope.setup {
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
}

-- find file
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- find git (files)
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

-- find everywhere
vim.keymap.set('n', '\\', extensions.live_grep_args.live_grep_args, {})

-- find buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- find help
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- find tags
vim.keymap.set('n', '<leader>ft', builtin.tags, {})

-- find recent
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
