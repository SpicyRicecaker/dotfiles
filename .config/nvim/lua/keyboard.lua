local function load_keybindings()
	vim.g.mapleader = ' '

	vim.api.nvim_set_keymap('n', '<Leader>ff',
	[[<Cmd>lua require('telescope.builtin').find_files()<CR>]],
	{noremap = true, silent = true})
	vim.api.nvim_set_keymap('n', '<Leader>fg',
	[[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],
	{noremap = true, silent = true})
	vim.api.nvim_set_keymap('n', '<Leader>fb',
	[[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
	{noremap = true, silent = true})
	vim.api.nvim_set_keymap('n', '<Leader>fh',
	[[<Cmd>lua require('telescope.builtin').help_tags()<CR>]],
	{noremap = true, silent = true})
	-- search inside file, also really useful
	vim.api.nvim_set_keymap('n', '<leader>fi', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", {noremap = true})

	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.o.rnu = true
	vim.o.number = true
	vim.o.smarttab = true
	vim.o.tabstop = 2
	vim.o.shiftwidth = 2
  vim.o.breakindent = true
	vim.o.expandtab = true
	vim.o.scl = 'number'
	vim.o.hidden = true
	vim.o.backupcopy = 'no'
	vim.o.cmdheight = 2
	vim.o.updatetime = 300
	--- Currently using AutoSave.nvim so
	-- vim.o.awa = true

	vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

	-- Save your pinky
	vim.api.nvim_set_keymap('i', 'jk', '<Esc>:w<Enter>', {silent = true, noremap = true})
end

load_keybindings()
