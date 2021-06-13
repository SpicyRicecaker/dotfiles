-- # PLUGINS
-- Plugin management using `packer.nvim`
-- *TODO* how do we get rid of all the linting errors bruh
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use 'sainnhe/gruvbox-material'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- use 'junegunn/goyo.vim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/lsp-status.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  -- use {'glacambre/firenvim', run = ':firenvim#install(0)'}
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use 'b3nj5m1n/kommentary'
  use 'mhartington/formatter.nvim'
  -- File explorer basically
  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}
end)
