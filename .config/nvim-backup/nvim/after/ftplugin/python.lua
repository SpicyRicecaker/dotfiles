local bufnr = vim.api.nvim_get_current_buf()
local file_name = vim.api.nvim_buf_get_name(bufnr)
-- print("current buffer number is `" .. bufnr .. "`! Recorded file name " .. file_name)
-- local file_name = vim.api.nvim_buf_get_name(bufnr)
vim.keymap.set('n', '45', 
    function () vim.fn.system(string.format("kittles --adjacent --dont-take-focus -c 'python %s'", file_name)) end,
    { silent = true, buffer = bufnr }
)
vim.keymap.set('n', '67', 
    function () vim.fn.system(string.format("kittles --adjacent -c 'python %s'", file_name)) end,
    { silent = true, buffer = bufnr }
)
-- vim.api.nvim_clear_autocmds({ group = "BufReadPost", buffer = bufnr, })
-- vim.api.nvim_clear_autocmds({ buffer = bufnr, })
