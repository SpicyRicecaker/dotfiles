return {
    { 'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { 
                preset = 'default',
                ['<C-l>'] = { 'show_signature', 'hide_signature', 'fallback' }
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { 
                menu = { auto_show = false },
                documentation = { auto_show = false }
            },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    -- "folke/lazydev.nvim",
    "folke/which-key.nvim",
    { "nvim-treesitter/nvim-treesitter-context",
        config = function ()
            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end
    },
    -- { "jake-stewart/multicursor.nvim",
    --     branch = "1.0",
    --     config = function()
    --         local mc = require("multicursor-nvim")
    --         mc.setup()
    --  local set = vim.keymap.set
    --
    --         set("n", "<c-leftmouse>", mc.handleMouse)
    --         set("n", "<c-leftdrag>", mc.handleMouseDrag)
    --         set("n", "<c-leftrelease>", mc.handleMouseRelease)
    --     end
    -- },
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
    -- { "folke/persistence.nvim",
    --     event = "BufReadPre", 
    --     lazy = false,
    --     {
    --         dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
    --         -- minimum number of file buffers that need to be open to save
    --         -- Set to 0 to always save
    --         need = 1,
    --         branch = true, -- use git branch to save session
    --     },
    --     config = function ()
    --         -- load the session for the current directory
    --         vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
    --
    --         -- select a session to load
    --         vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
    --
    --         -- load the last session
    --         vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
    --
    --         -- stop Persistence => session won't be saved on exit vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end) end
    -- },
    --
    {
        "olimorris/persisted.nvim",
        event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
        lazy = false,
        opts = {
            -- Your config goes here ...
        },
        config = function ()
            local persisted = require("persisted")
            vim.keymap.set('n', '<leader>hp',
                function ()
                    vim.cmd("Persisted select")
                end
            )
            vim.keymap.set('n', '<leader>hs',
                function ()
                    vim.cmd("Persisted save")
                end
            )
            vim.keymap.set('n', '<leader>hr',
                function ()
                    vim.cmd("Persisted load_last")
                end
            )
        end
    },
    { "mrjones2014/smart-splits.nvim",
        lazy = false,
        config = function ()
            local s = require('smart-splits')
            -- recommended mappings
            -- resizing splits
            -- these keymaps will also accept a range,
            -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
            -- moving between splits
            for _, m in ipairs {'i','n'} do
                -- resize
                vim.keymap.set(m, '<A-h>', s.resize_left, { noremap = true })
                vim.keymap.set(m, '<A-j>', s.resize_down, { noremap = true })
                vim.keymap.set(m, '<A-k>', s.resize_up, { noremap = true })
                vim.keymap.set(m, '<A-l>', s.resize_right, { noremap = true })
                -- moving
                vim.keymap.set(m, '<C-h>', s.move_cursor_left, { noremap = true })
                vim.keymap.set(m, '<C-j>', s.move_cursor_down, { noremap = true })
                vim.keymap.set(m, '<C-k>', s.move_cursor_up, { noremap = true })
                vim.keymap.set(m, '<C-l>', s.move_cursor_right, { noremap = true })
                vim.keymap.set(m, '<C-\\>', s.move_cursor_previous, { noremap = true })
                -- swapping
            end
            -- swapping buffers between windows
            vim.keymap.set('n', '<leader><leader>h', s.swap_buf_left)
            vim.keymap.set('n', '<leader><leader>j', s.swap_buf_down)
            vim.keymap.set('n', '<leader><leader>k', s.swap_buf_up)
            vim.keymap.set('n', '<leader><leader>l', s.swap_buf_right)
        end },
    { "gbprod/yanky.nvim" },
    { "folke/trouble.nvim",
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
    { "neovim/nvim-lspconfig",
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
    { 'MagicDuck/grug-far.nvim',
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require('grug-far').setup({
                -- options, see Configuration section below
                vim.keymap.set("n", "<leader>g", function () vim.cmd"GrugFar" end)
                -- there are no required options atm
            });
        end
    },
    { 'stevearc/oil.nvim',
        opts = {
            -- This is what replaces netrw
            default_file_explorer = true,
            keymaps = {
                -- Default is ` to cd, but you can remap it if you prefer
                ["<leader>cd"] = "actions.cd",
                -- You can also use `tcd` to only change directory for the current TA
                ["<leader>td"] = "actions.tcd",
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["gr"] = "actions.refresh"
            },
            view_options = {
                show_hidden = true
            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons", "nvim-mini/mini.icons" },
        config = function (_, opts)
            -- print(opts:default_file_explorer)
            require("oil").setup(opts)
            vim.keymap.set("n", "<leader>e", function () vim.cmd"Oil" end)
        end,
        lazy = false
    },
    { 'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function () 

            local u = require'ufo'
            vim.keymap.set('n', 'zR', u.openAllFolds)
            vim.keymap.set('n', 'zM', 
                function ()
                    vim.b.ufo_foldlevel = vim.b.ufo_foldlevel or 0
                    vim.b.ufo_foldlevel = 0
                    u.closeFoldsWith(vim.b.ufo_foldlevel)
                end
            )
            vim.keymap.set('n', 'zr',
                function ()
                    vim.b.ufo_foldlevel = vim.b.ufo_foldlevel or 0
                    vim.b.ufo_foldlevel = math.min(vim.b.ufo_foldlevel + 1, 99)
                    u.closeFoldsWith(vim.b.ufo_foldlevel)
                end
            )
            vim.keymap.set('n', 'zm',
                function ()
                    vim.b.ufo_foldlevel = vim.b.ufo_foldlevel or 0
                    vim.b.ufo_foldlevel = math.max(0, vim.b.ufo_foldlevel - 1)
                    u.closeFoldsWith(vim.b.ufo_foldlevel)
                end
            )

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, ''})
                return newVirtText
            end

            require('ufo').setup({
                open_fold_hl_timeout = 0,
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end,
                -- fold_virt_text_handler = handler
            })
        end
    },
    { "ibhagwan/fzf-lua",
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
            { "<leader>fu", "<cmd>FzfLua undotree<cr>", desc = "Undo Tree" },
            { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Highlights" },
            { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
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
    { "folke/neoconf.nvim",
        cmd = "Neoconf" },
    { "folke/flash.nvim",
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
        dependencies = { "nvim-mini/mini.icons" },
        config = function ()
            -- require('mini.snippets').setup()
            -- require('mini.completion').setup({
            --     mappings = {
            --         scroll_down = '',
            --         scroll_up = '',
            --     }
            -- })
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
            require('mini.test').setup()
            -- require('mini.ai').setup()

            -- local spec_pair = require('mini.ai').gen_spec.pair
            -- vim.b.miniai_config = {
            --     custom_textobjects = {
            --         ['*'] = spec_pair('*', '*', { type = 'greedy' }),
            --         ['_'] = spec_pair('_', '_', { type = 'greedy' }),
            --         ['|'] = spec_pair('|', '|', { type = 'greedy' }),
            --     },
            -- }
            -- require('mini.pick').setup()
            -- vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files, { desc = 'mini.pick files' })
            -- vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep, { desc = 'mini.pick grep' })
            -- vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = 'mini.pick buffers' })
            -- vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = 'mini.pick help' })
        end,
    },
    { 'mfussenegger/nvim-dap',
        config = function ()
            local dap = require('dap')
            vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
        end
    },
    { 'mrcjkb/rustaceanvim',
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
                            enable = false,
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
    { 'nvim-treesitter/nvim-treesitter',
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
    { 'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            ensure_installed = { "rust", "wgsl", "toml", "json", "lua", "markdown", "markdown_inline", "bash", "c", "diff", "html", "javascript", "jsdoc", "luadoc", "luap", "printf", "python", "query", "regex", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml" },
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
    { 'max397574/better-escape.nvim',
        config = function()
            require'better_escape'.setup {
                default_mappings = false,
                mappings = {
                    -- make sure not to include visual mode here
                    i = { j = { k = "<Esc>" }, },
                    c = { j = { k = "<C-c>" }, },
                    t = { j = { k = "<C-\\><C-n>" } },
                    s = { j = { k = "<Esc>" } }
                }
            }
        end
    },
    { 'christoomey/vim-tmux-navigator' }
}
