vim.loader.enable()
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
vim.keymap.set('n', '<leader>d',
    function ()
        local res = vim.cmd("!ls")
        print(res)
    end
)
vim.keymap.set('n', '<leader>l',
    function ()
        local bufnr = vim.api.nvim_get_current_buf()
        local file_name = vim.api.nvim_buf_get_name(bufnr)
        local curloc = vim.api.nvim_win_get_cursor(0)

        local i_rev = string.find(string.reverse(file_name), '/')
        local i = -i_rev + string.len(file_name)
        local dir = string.sub(file_name, 1, i)

        -- pushd to directory
        -- jj edit commit
        -- edit specific file
        -- popd
        --


        local cmd_get_id_commit = string.format("cd '%s'; jj log -r @ -G | head -n 1 | rg -o \"^[^\\s]*\"", dir)
        -- local cmd_get_commit = string.format("cd ~/git/fd; jj log -r @ -G | head -n 1 | rg -o \"^[^\\s]*\"", dir)
        -- local cmd_get_id_commit = "cd ~/git/fd; jj log -r @ -G | head -n 1 | rg -o \"^[^\\s]*\""

        local handle = io.popen(cmd_get_id_commit)
        local id_commit = string.sub(handle:read("*a"), 1, -2)
        handle:close()

        local hash = string.format([[pushd %s
jj edit %s
nvim %s -c "call cursor(%s,%s)"
popd]], dir, id_commit, file_name, curloc[1], curloc[2])

        vim.fn.setreg("+", hash)
    end
)


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

-- code modified from code by user fpohtmet
-- @ https://www.reddit.com/r/neovim/comments/1ct96ab/comment/l4aw547/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
function keep_some_lines_visible_around_cursor (yes)
    if yes then
        vim.opt_local.scrolloff = 999
    else
        vim.opt_local.scrolloff = 0
    end
end

function set_cursor_is_visible (visible)
    if visible then
        vim.cmd[["
            hi Cursor blend=0
            set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor
        "]]
    else
        vim.cmd[["
            set termguicolors
            hi Cursor blend=100
            set guicursor+=a:Cursor/lCursor
        "]]
    end
end

function toggle_view_man ()
    vim.b.man_nav_enabled = vim.b.man_nav_enabled and vim.b.man_nav_enabled or false
    local target_man_nav_enabled = not vim.b.man_nav_enabled
    if target_man_nav_enabled then
        vim.api.nvim_input('M')
        keep_some_lines_visible_around_cursor(true)
        set_cursor_is_visible(false)
    else
        keep_some_lines_visible_around_cursor(false)
        set_cursor_is_visible(true)
    end
    vim.b.man_nav_enabled = target_man_nav_enabled
end

vim.keymap.set("n", "<leader>c", toggle_view_man, { desc = "Toggle Man Nav Mode", silent = true, nowait = true })

-- Toggle the "VS Code Error List"
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

function myprint ()
    vim.cmd'luafile %'
    local v = vim.cmd'echo &foldlevel'
    print(v)
end


