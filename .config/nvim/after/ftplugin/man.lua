-- local bufnr = vim.api.nvim_get_current_buf()
-- local file_name = vim.api.nvim_buf_get_name(bufnr)

-- vim.keymap.set('n', '67', function () vim.fn.system(string.format("kittles --adjacent -c 'lua %s'", file_name)) end,
--     { silent = true, buffer = bufnr }
-- )
-- vim.keymap.set('n', '45', function () vim.fn.system(string.format("kittles --adjacent --dont-take-focus -c 'lua %s'"), file_name) end,
--     { silent = true, buffer = bufnr }
-- )

-- print('hiiiiiiiiiiiiiiiiiiiiiiiiiiii')
vim.cmd"norm M"
toggle_view_man()
