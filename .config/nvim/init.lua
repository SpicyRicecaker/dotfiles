vim.g.mapleader = " "

vim.o.expandtab = true
vim.o.shiftwidth = 4
-- line number relative
-- vim.o.relativenumber = true
-- save on focus shift
vim.cmd[[au FocusLost * silent :wa]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            vim.cmd[[
            nnoremap <leader>ff <cmd>Telescope find_files<cr>
            nnoremap <leader>fg <cmd>Telescope live_grep<cr>
            nnoremap <leader>fb <cmd>Telescope buffers<cr>
            nnoremap <leader>fh <cmd>Telescope help_tags<cr>
            ]]
        end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
            -- vim.keymap.set('i', '<C-_>', '<Plug>(comment_toggle_linewise)', {expr = true})
            vim.keymap.set('i', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR><Esc>A')
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "lua", "rust", "toml", "markdown"},
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
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
                }
            }
        end,
    }

    use {
        "max397574/better-escape.nvim",
        config = function()
            require'better_escape'.setup()
        end,
    }

    use {
        'sainnhe/gruvbox-material',
        config = function()
            vim.g.gruvbox_material_background = 'medium'
            vim.g.gruvbox_material_better_performance = 1
            vim.cmd[[colorscheme gruvbox-material]]
        end,
    }
end)
