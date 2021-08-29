-- # TELESCOPE

-- ## Keybinds

-- find based off file name
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true})
-- 'live grep', global searching across OS!
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
-- search buffers, really useful
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap = true})
-- search help, really useful
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap = true})
-- search inside file, also really useful
vim.api.nvim_set_keymap('n', '<leader>fi', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", {noremap = true})

-- ## Setup

require('telescope').setup{}
