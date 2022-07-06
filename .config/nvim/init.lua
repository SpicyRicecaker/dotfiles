vim.g.mapleader = ' '

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
-- never use mouse in vim lol
-- also it's distracting when you're typing but misclick trackpad
vim.o.mouse = nil
-- line number relative
-- vim.o.relativenumber = true
-- save on focus shift, breaks like 99% of extensions but saves my pinky
vim.cmd[[au FocusLost * silent :wa]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

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
        requires = { { 'nvim-telescope/telescope-file-browser.nvim' } },
        config = function()
            require('telescope').load_extension 'file_browser'
            vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>Telescope file_browser<CR>', { noremap = true })
        end
    }

    use {
        'numToStr/Comment.nvim',
        -- copied code from https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
        -- not sure how slow this makes neovim, but hopefully it's async and it's still gotta be faster than vscode. Probably.
        config = function()
            require('Comment').setup {
                pre_hook = function(ctx)
                    local U = require 'Comment.utils'

                    local location = nil
                    if ctx.ctype == U.ctype.block then
                        location = require('ts_context_commentstring.utils').get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    return require('ts_context_commentstring.internal').calculate_commentstring {
                        key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
                        location = location,
                    }
                end,
            }
            -- for some reason after some time vim started recognizing `ctrl+/` as `<C-/>` instead of `^_`
            vim.keymap.set('i', '<C-/>', '<cmd>lua require("Comment.api").toggle_current_linewise()<CR><Esc>A')
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = { {'JoosepAlviste/nvim-ts-context-commentstring'} },
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { 'lua', 'rust', 'toml', 'markdown', 'tsx', 'typescript', 'javascript', 'html', 'css', 'json', 'scheme', 'wgsl'},
                highlight = {
                    enable = true,
                    -- I want markdown italics, so enabling this for now
                    additional_vim_regex_highlighting = true
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
                    -- currently disabling as it's buggy with rust if let statements
                    -- vim default indent is good enough
                    enable = false
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

    use {
        'sainnhe/gruvbox-material',
        config = function()
            -- vim.g.gruvbox_material_background = 'medium'
            -- vim.g.gruvbox_material_better_performance = 1
            -- vim.cmd[[colorscheme gruvbox-material]]
        end,
    }

    use {
        'rebelot/kanagawa.nvim',
        config = function()
            vim.cmd[[colorscheme kanagawa]]
        end
    }

    use 'tpope/vim-surround'

    -- debug 
    -- use 'nvim-treesitter/playground'

    use 'mattn/emmet-vim'
end)
