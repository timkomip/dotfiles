local wk = require("which-key")
wk.setup()

-- Example:

-- wk.register({
--   o = { "<cmd>q<cr>", "Close File" }, -- create a binding with label
--   f = {
--     name = "Find...",
--     f = { "<cmd>Files<cr>", "Find Files" }

--   },
--   r = {
--     name = "Run..", -- optional group name
--     f = { "<cmd>TestFile<cr>", "Test File" }, -- create a binding with label
--     -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
--     -- n = { "New File" }, -- just a label. don't create any mapping
--     -- e = "Edit File", -- same as above
--     -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
--     -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
--   },
-- }, { prefix = "<leader>" })
