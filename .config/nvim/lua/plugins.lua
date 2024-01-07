vim.g.skip_ts_context_commentstring_module = true
vim.g.mapleader = ' '
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.clipboard = "unnamedplus"

vim.o.rnu = true
vim.o.number = true
vim.o.clipboard = 'unnamedplus'

-- https://neovim.io/doc/user/quickref.html
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

-- save on focus shift
-- for files which do not yet have a name, an annoying error is thrown on alt tab...
vim.cmd[[au FocusLost * silent :wa]]

-- tsx support, vim style, instead of treesitter, since treesitter is perma bugged.
-- Though for webdev specifically, vscode is unequivocally better
vim.cmd[[au BufNewFile,BufRead *.tsx setf typescriptreact]]

-- TODO only allow user to run this in a rust file
-- vim.api.nvim_set_keymap('n', '<leader><leader>', 'ggVG:!rustfmt<CR><C-o>', { noremap = true })

-- boostrap 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- q: is the `config` function of a extension still run if it is *not* loaded?
-- we can test this by purposely setting a lazy function to true and checking if a known valid function (that is run before commands in the main file) still execute
-- as zybooks are not in use currently however, is firenvim still useful?

require('lazy').setup({
    -- {
    --     'glacambre/firenvim',
    --     lazy = not vim.g.started_by_firenvim,
    --     build = function() 
    --         vim.fn['firenvim#install'](0)
    --     end 
    -- },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 
            'nvim-lua/plenary.nvim', 
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files)
            vim.keymap.set('n', '<leader>fg', builtin.live_grep)
            vim.keymap.set('n', '<leader>fb', builtin.buffers)
            vim.keymap.set('n', '<leader>fh', builtin.help_tags)
        end,
    },

    { 
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')
            telescope.load_extension 'file_browser'
            -- can't figure out a way to use vim.keymap.set for this line
            vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>Telescope file_browser<CR>', { noremap = true })
        end
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            -- see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
            require('Comment').setup{
               pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), 
            }
            vim.keymap.set('i', '<C-_>', "<cmd>lua require('Comment.api').toggle.linewise.current()<CR><Esc>A")
            -- for some reason after some time vim started recognizing `ctrl+/` as `<C-/>` instead of `^_`
            -- see :h command.api for the code below
            vim.keymap.set('i', '<C-/>', "<cmd>lua require('Comment.api').toggle.linewise.current()<CR><Esc>A")
        end
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        config = function()
            -- load our custom tree-sitter grammar
            local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
            parser_configs.wgsl = {
                install_info = {
                    url = '~/git/tree-sitter-wgsl',
                    files = { 'src/parser.c' },
                }
            }
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { 'lua', 'rust', 'toml', 'markdown', 'tsx', 'typescript', 'javascript', 'html', 'css', 'json', 'scheme', 'wgsl', 'cpp', 'fish' },
                -- install parsers in parallel
                sync_install = false,
                highlight = {
                    enable = true,
                    -- Treesitter highlighting is really slow. Create any
                    -- typescript or javascript file and add ~100 lines of
                    -- code. You'll notice slight input lag. Up it to 4000,
                    -- and you can barely type. There's no problem with typing
                    -- on VSCode on basically files of any size.
                    -- This is with an LSP and highlighting and whatever else.
                    --
                    -- The same happens with rust as well. Though it's fine for
                    -- a greater number of lines, latency certainly goes up.
                    -- While VSCode is able to type regularly, neovim is not
                    -- disable = { 'typescript', 'javascript', 'rust'},
                    -- I want markdown italics, so enabling this for now
                    -- additional_vim_regex_highlighting = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        scope_incremental = '<CR>',
                        node_incremental = '<TAB>',
                        node_decremental = '<S-TAB>',
                    },
                },
                indent = {
                    enable = true
                },
            }
            -- wgsl is scuffed for some reason, have to manually add this
            vim.cmd[[au BufRead,BufNewFile *.wgsl set filetype=wgsl]]
        end,
    },

    {
        'max397574/better-escape.nvim',
        config = function()
            require'better_escape'.setup()
        end,
    },

    -- {
    --     'sainnhe/gruvbox-material',
    --     config = function()
    --         -- vim.g.gruvbox_material_background = 'medium'
    --         -- vim.g.gruvbox_material_better_performance = 1
    --         -- vim.cmd[[colorscheme gruvbox-material]]
    --     end,
    -- },

    {
        'rebelot/kanagawa.nvim',
        config = function()
	    vim.cmd[[colorscheme kanagawa]]
        end
    },

    -- {
    --     "catppuccin/nvim",
    --     as = "catppuccin",
    --     config = function()
    --         require("catppuccin").setup {
    --             flavour = "macchiato" -- mocha, macchiato, frappe, latte
    --         }
    --         vim.api.nvim_command "colorscheme catppuccin"
    --     end
    -- },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },

    -- debug 
    --{ 'nvim-treesitter/playground' },
    --{ 'tweekmonster/startuptime.vim' },

    -- TODO: hasn't been updated in 2 years. replace with mason + emmet lsp
    -- { 'mattn/emmet-vim' },
    -- { 'leafgarland/typescript-vim'},
    -- { 'peitalin/vim-jsx-typescript'},
}, {
    dev = {
        path = "~/projects",
        patterns = { "nvim-treesitter" },
        fallback = false
    }
})
