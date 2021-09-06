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

  -- Debug!
  -- use 'mfussenegger/nvim-dap'
  -- Add cool tree
  -- use {
  --   'theHamsta/nvim-dap-virtual-text', requires = {
  --     'mfussenegger/nvim-dap',
  --     'nvim-treesitter/nvim-treesitter'
  --   },
  --   config = function () vim.g.dap_virtual_text = true end
  -- }

  -- use { "rcarriga/nvim-dap-ui", requires = {'mfussenegger/nvim-dap'} }

  -- Autocomplete!
  use { 'hrsh7th/nvim-cmp', requires = {
    -- Source: lsp
    'hrsh7th/cmp-nvim-lsp',
    -- Source: buffer
    'hrsh7th/cmp-buffer',
    -- Snippet engine
    'L3MON4D3/LuaSnip',
    -- Source: snippet engine
    'saadparwaiz1/cmp_luasnip'
  }}


  -- TODO Maybe add these as deps to nvim-lspconfig so we don't load both at the same time when not using builtin lsp
  -- Rust!
  use {
    'simrat39/rust-tools.nvim', requires = {
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
