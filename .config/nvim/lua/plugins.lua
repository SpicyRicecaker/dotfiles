return {
    -- "folke/lazydev.nvim",
    "folke/which-key.nvim",
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()
	    local set = vim.keymap.set

            set("n", "<c-leftmouse>", mc.handleMouse)
            set("n", "<c-leftdrag>", mc.handleMouseDrag)
            set("n", "<c-leftrelease>", mc.handleMouseRelease)
        end
    },
    -- { 
    --     "HiPhish/rainbow-delimiters.nvim",
    --     config = function ()
    --         vim.cmd"colorscheme unokai"
    --         vim.cmd"highlight! link RainbowDelimiterRed markdownH1Delimiter"
    --         vim.cmd"highlight! link RainbowDelimiterOrange markdownH3Delimiter"
    --         vim.cmd"highlight! link RainbowDelimiterYellow markdownH2Delimiter"
    --         vim.cmd"highlight! link RainbowDelimiterGreen  markdownH6Delimiter"
    --         vim.cmd"highlight! link RainbowDelimiterCyan markdownH5Delimiter"
    --         vim.cmd"highlight! link RainbowDelimiterBlue markdownH4Delimiter"
    --         vim.cmd"highlight! link RainbowDelimiterViolet Constant"
    --         vim.cmd"highlight! link MatchParen htmlBold"
    --     end
    -- },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            lsps = {'lsp_lua', 'wgsl_analyzer'}

            for _i, value in ipairs(lsps) do
                vim.lsp.enable(value)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "wgsl",
                callback = function()
                    vim.bo.commentstring = "// %s"
                end
            })
        end
    },
    {
        'MagicDuck/grug-far.nvim',
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
            });
        end
    },
    {
        'stevearc/oil.nvim',
        opts = {
            -- This is what replaces netrw
            default_file_explorer = true,
            keymaps = {
                -- Default is ` to cd, but you can remap it if you prefer
                ["<leader>cd"] = "actions.cd",
                -- You can also use `tcd` to only change directory for the current TAB
                ["<leader>td"] = "actions.tcd",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function () 
            local u = require'ufo'
            vim.keymap.set('n', 'zR', u.openAllFolds)
            vim.keymap.set('n', 'zM', u.closeAllFolds)
            vim.keymap.set('n', 'zr', u.openFoldsExceptKinds)
            vim.keymap.set('n', 'zm', u.closeFoldsWith)
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" },
        keys = {
            -- The "Big 4" equivalents
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>FzfLua live_grep_native<cr>", desc = "Live Grep (Project)" },
            { "<leader>fi", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Live Grep (File)" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
            -- Bonus: Resume last search (super useful)
            { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume Last Search" },
            { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
            { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
            { "<leader>fc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
            { "<leader>fu", "<cmd>FzfLua undo_tree<cr>", desc = "Undo Tree" },
            { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Highlights" },
        },
        opts = {
            -- This makes the previewer look/feel like Telescope
            winopts = {
                preview = {
                    layout = "vertical", -- or 'horizontal'
                },
            },
            keymap = {
                builtin = {
                    -- Familiar Telescope-style scrolling inside the preview window
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
            },
        },
        config = function ()
            local config = require("fzf-lua.config")
            local actions = require("trouble.sources.fzf").actions
            config.defaults.actions.files["ctrl-t"] = actions.open
        end
    },
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {
        search = { enabled = true }
      },
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
    },
    { 'nvim-mini/mini.nvim',
        version = false,
        config = function ()
            require('mini.completion').setup()
            require('mini.surround').setup({
                mappings = {
                    add = '<leader>sa',
                    delete = '<leader>sd',
                    find = '<leader>sf',
                    find_left = '<leader>sF',
                    highlight = '<leader>sh',
                    replace = '<leader>sr',

                    -- Add this only if you don't want to use extended mappings
                    suffix_last = '',
                    suffix_next = '',
                },
                search_method = 'cover_or_next',
            })
            -- require('mini.pick').setup()
            -- vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files, { desc = 'mini.pick files' })
            -- vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep, { desc = 'mini.pick grep' })
            -- vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = 'mini.pick buffers' })
            -- vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = 'mini.pick help' })
        end
    },
    { 'mfussenegger/nvim-dap',
        config = function ()
            local dap = require('dap')
            vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
        dependencies = 'mfussenegger/nvim-dap',
        config = function ()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                },
                -- LSP configuration
                server = {
                    ['init_options'] = {
                        rustfmt = {
                            rangeFormatting = {
                                enable = true,
                            },
                        },
                    },
                    settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = {
                            rustfmt = {
                                rangeFormatting = {
                                    enable = true
                                }
                            }
                        },
                    },
                },
                -- DAP configuration
                dap = {
                },
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        build = ':TSUpdate',
        -- config = function(_, opts)
        -- load our custom tree-sitter grammar
        -- local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
        -- parser_configs.wgsl = {
        --     install_info = {
        --         url = '~/git/tree-sitter-wgsl',
        --         files = { 'src/parser.c' },
        --     }
        -- }
        --
        -- local TS = require("nvim-treesitter")
        -- print('hi')
        -- TS.setup(opts)

        -- wgsl is scuffed for some reason, have to manually add this
        -- vim.cmd[[au BufRead,BufNewFile *.wgsl set filetype=wgsl]]
        -- end
    },
    {
        'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            ensure_installed = { "rust", "wgsl", "toml", "json", "lua", "markdown", "markdown_inline", "bash", "c", "diff", "html", "javascript", "jsdoc", "jsonc", "luadoc", "luap", "printf", "python", "query", "regex", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml" },
            fold = { enable = true },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = { 
                enable = true,
                keymaps = {
                    init_selection = "<A-o>",
                    node_incremental = "<A-o>",
                    scope_incremental = "<A-O>",
                    node_decremental = "<A-i>",
                    -- init_selection = 'gnn',
                    -- scope_incremental = 'gnn',
                    -- node_incremental = 'gni',
                    -- node_decremental = 'gnd',
                },
            },
        },
    },
    {
        'max397574/better-escape.nvim',
        config = function()
            require'better_escape'.setup {
                default_mappings = false,
                mappings = {
                    -- make sure not to include visual mode here
                    i = { j = { k = "<Esc>", j = "<Esc>", }, },
                    c = { j = { k = "<C-c>", j = "<C-c>", }, },
                    t = { j = { k = "<C-\\><C-n>" } },
                    s = { j = { k = "<Esc>" } }
                }
            }
        end
    }
}
