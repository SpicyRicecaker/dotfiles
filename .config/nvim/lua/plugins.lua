return {
    "folke/lazydev.nvim",
    "folke/which-key.nvim",
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
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            -- The "Big 4" equivalents
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep (Project)" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
            -- Bonus: Resume last search (super useful)
            { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume Last Search" },
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
        }
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
        dependencies = 'mfussenegger/nvim-dap'
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
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "rust"
            },
            fold = { enable = true },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = { 
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    scope_incremental = 'gnn',
                    node_incremental = 'gni',
                    node_decremental = 'gnd',
                },
            },
        },
    },
    {
        'max397574/better-escape.nvim',
        config = function()
            require'better_escape'.setup()
        end,
    },
}
