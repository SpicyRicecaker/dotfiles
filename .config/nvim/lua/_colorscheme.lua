-- # Color Scheme
-- This file sets up color schemes as well as syntax highlighting stuff
--
-- Neovim defaults to 256-bit colors
-- If the terminal supports it, setting `termguicolors` enables true color, 24-bit 16 million colors
if vim.fn.has('termguicolors') == 1 then vim.o.termguicolors = true end
-- Enable syntax highlighting in nvim
vim.cmd 'syntax on'

-- ## Colorscheme
vim.o.background = 'dark'
-- Gruvbox-material config options
vim.g.gruvbox_material_background = 'soft'
vim.cmd 'colorscheme gruvbox-material'

-- Enable italic
vim.g.gruvbox_material_enable_italic = 1
-- Disable italic comments
vim.g.gruvbox_material_disable_italic_comment = 1
-- Enable bold font for functions
vim.g.gruvbox_material_enable_bold = 1

-- Set cursor color
vim.g.gruvbox_material_cursor = 'purple'

-- Enable preload
vim.g.gruvbox_material_better_performance = 1

-- Set neovide stuff
vim.cmd [[set guifont=Fira\ Code\ Nerd\ Font:h30]]

-- Syntax highlighting of embedded code
vim.g.vimsyn_embed = 'l'

-- ## Treesitter (better syntax highlighting)
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true -- false will disable the whole extension
        -- disable = { "c", "rust" },  -- list of language that will be disabled
    },
    indent = {enable = true},
    incremental_selection = {enable = true}
}

-- Folding based off of treesitter
vim.cmd [[set foldmethod=expr]]
-- vim.g.foldexpr = nvim_treesiter.foldexpr()
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
