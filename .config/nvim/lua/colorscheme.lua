local function treesitter()
    require 'nvim-treesitter.install'.compilers = { "clang" }
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {enable = true, indent = {enable = true}}
    }
    vim.cmd 'set foldmethod=expr'
    vim.cmd 'set foldexpr=nvim_treesitter#foldexpr()'

end

local function color_scheme()
    vim.g.background = 'dark';
    vim.g.gruvbox_material_background = 'soft';
    vim.g.gruvbox_material_enable_italic = 1;
    vim.g.gruvbox_material_better_performance = 1;

    vim.cmd 'colorscheme gruvbox-material';
end

-- local function other() vim.cmd [[set guifont=Fira\ Code\ Nerd\ Font:h30]] end

local function load()
    color_scheme();
    treesitter();
    -- other();
end

load()
