-- Keep in mind that if any personal lua files have the same name as one of the plugins below it will error
return require'packer'.startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Highlight
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Fuzzy search
    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}

    -- Colorscheme
    use 'sainnhe/gruvbox-material'

    -- LSP!
    use 'neovim/nvim-lspconfig'
    -- Autosave makes lsp feel a lot better!
    use 'Pocco81/AutoSave.nvim'
    -- Testing out native lsp rn, thanks to autosave
    -- use {'neoclide/coc.nvim', branch = 'release'}

    -- Rust!
    use {
      'simrat39/rust-tools.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'neovim/nvim-lspconfig',
        'nvim-telescope/telescope.nvim',
        'mfussenegger/nvim-dap'
      }
    }

    -- Comments!
    use 'b3nj5m1n/kommentary'

    -- Autopairing of open close parens
    use 'windwp/nvim-autopairs'

    -- VSCode sidebar
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

    -- Statusline
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
end)
