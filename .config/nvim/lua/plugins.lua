vim.g.mapleader = ' '
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true

-- save on focus shift, breaks like 99% of extensions but saves my pinky
vim.cmd[[au FocusLost * silent :wa]]

-- tsx support, vim style, instead of treesitter, since treesitter is perma bugged.
-- Though for webdev specifically, vscode is unequivocally better
vim.cmd[[au BufNewFile,BufRead *.tsx setf typescriptreact]]

vim.api.nvim_set_keymap('n', '<leader><leader>', 'ggVG:!rustfmt<CR><C-o>', { noremap = true })

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end 
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'} },
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true })
        end,
    }

    use { 
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { { 'nvim-telescope/telescope.nvim' } },
        config = function()
            require('telescope').load_extension 'file_browser'
            vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>Telescope file_browser<CR>', { noremap = true })
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup{
               pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), 
            }
            -- for some reason after some time vim started recognizing `ctrl+/` as `<C-/>` instead of `^_`
            -- see :h command.api for the code below
            vim.keymap.set('i', '<C-/>', "<cmd>lua require('Comment.api').toggle.linewise.current()<CR><Esc>A")
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = { {'JoosepAlviste/nvim-ts-context-commentstring'} },
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { 'lua', 'rust', 'toml', 'markdown', 'tsx', 'typescript', 'javascript', 'html', 'css', 'json', 'scheme', 'wgsl', 'cpp', 'fish'},
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
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false
                }
            }
            -- wgsl is scuffed for some reason, have to manually add this
            vim.cmd[[au BufRead,BufNewFile *.wgsl set filetype=wgsl]]
        end,
    }

    use {
        'max397574/better-escape.nvim',
        config = function()
            require'better_escape'.setup()
        end,
    }

    -- use {
    --     'sainnhe/gruvbox-material',
    --     config = function()
    --         -- vim.g.gruvbox_material_background = 'medium'
    --         -- vim.g.gruvbox_material_better_performance = 1
    --         -- vim.cmd[[colorscheme gruvbox-material]]
    --     end,
    -- }

    -- use {
    --     'rebelot/kanagawa.nvim',
    --     config = function()
    --         vim.cmd[[colorscheme kanagawa]]
    --     end
    -- }

    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup {
                flavour = "macchiato" -- mocha, macchiato, frappe, latte
            }
            vim.api.nvim_command "colorscheme catppuccin"
        end
    }

    use 'tpope/vim-surround'

    -- debug 
    --[[ use 'nvim-treesitter/playground' ]]
    --[[ use 'tweekmonster/startuptime.vim' ]]

    use 'mattn/emmet-vim'
    use 'leafgarland/typescript-vim'
    use 'peitalin/vim-jsx-typescript'
end)

