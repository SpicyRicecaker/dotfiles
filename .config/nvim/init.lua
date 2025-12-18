require("config.lazy")
require("lazy").setup("plugins")

vim.g.mapleader = ' '
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.rnu = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldopen:remove("block")
vim.opt.foldmethod = "manual"

vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-m-f>', '<S-Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-m-b>', '<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<m-bs>', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-p>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-n>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true })
vim.api.nvim_set_keymap('i', '<D-v>', '<C-r>+', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc>lC', { noremap = true })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

vim.keymap.set("n", "<F8>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<S-F8>", vim.diagnostic.goto_prev)

-- Toggle the "VS Code Error List"
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

