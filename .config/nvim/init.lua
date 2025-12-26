require("config.lazy")
require("lazy").setup("plugins")
vim.cmd("syntax off")
-- vim.api.nvim_set_hl(0, '@lsp.type.function', {})
-- vim.cmd("colorscheme unokai")

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
vim.opt.signcolumn = "number"
vim.opt.wrap = false

-- vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-m-f>', '<S-Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-m-b>', '<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<m-bs>', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-p>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-n>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true })
vim.api.nvim_set_keymap('i', '<D-v>', '<C-r>+', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc>lC', { noremap = true })
vim.api.nvim_set_keymap('i', '<D-d>', '<Esc>:w<cr>a', { noremap = true })
vim.api.nvim_set_keymap('n', '<D-d>', ':w<cr>', { noremap = true })

vim.keymap.set('n', '67', function () vim.fn.system("kittles --adjacent -c 'cargo run'") end)
vim.keymap.set('n', '45', function () vim.fn.system("kittles --adjacent --dont-take-focus -c 'cargo run'") end)

vim.keymap.set('i', '<D-k>', ':<esc>q<cr>')
vim.keymap.set('n', '<D-k>', ':q<cr>')

vim.keymap.set('n', '<leader>i', function () vim.opt.wrap = not vim.opt.wrap:get() end, { desc = 'Toggle [w]ord wrap' })
vim.keymap.set('n', '<leader>j', ':', { desc = "Command Mode" })
vim.keymap.set({'n', 'i'}, '<F2>', vim.lsp.buf.rename, { desc = 'LSP Rename' })
-- Format code (Works in both Normal and Visual mode)
vim.keymap.set({ 'n', 'v' }, '<leader>o', function()
    vim.lsp.buf.format({ async = true })
end, { desc = 'LSP: Format [f]ile or selection' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gu', vim.lsp.buf.implementation, opts)

vim.keymap.set("n", "<F8>", function () vim.diagnostic.jump{count=1, float=true} end)
vim.keymap.set("n", "<F20>", function () vim.diagnostic.jump{count=-1, float=true} end)

-- Toggle the "VS Code Error List"
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

function myprint ()
    vim.cmd'luafile %'
    local v = vim.cmd'echo &foldlevel'
    print(v)
end
