-- # Color Scheme
-- This file sets up color schemes as well as syntax highlighting stuff
-- *TODO* where the fk do we put treesitter
--
-- Neovim defaults to 256-bit colors
-- If the terminal supports it, setting `termguicolors` enables true color, 24-bit 16 million colors
if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
end
-- Enable syntax highlighting in nvim
vim.cmd'syntax on'
-- Set colorscheme to gruvbox
vim.o.background = 'dark'
vim.g.gruvbox_material_background = 'soft'
vim.cmd'colorscheme gruvbox-material'
-- Syntax highlighting of embedded code
vim.g.vimsyn_embed = 'l'

-- ## Treesitter (better syntax highlighting)
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}

-- Folding based off of treesitter
vim.cmd[[set foldmethod=expr]]
-- vim.g.foldexpr = nvim_treesiter.foldexpr()
vim.cmd[[set foldexpr=nvim_treesitter#foldexpr()]]
