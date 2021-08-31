-- Keep in mind that if any personal lua files have the same name as one of the plugins below it will error
return require'packer'.startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Post-install/update hook with neovim command
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}

    use 'sainnhe/gruvbox-material'

    use 'neovim/nvim-lspconfig'

    use 'b3nj5m1n/kommentary'

    use {'neoclide/coc.nvim', branch = 'release'}

    use 'Pocco81/AutoSave.nvim'

    use 'windwp/nvim-autopairs'

    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    -- Use specific branch, dependency and run lua file after load
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
end)
