  -- # MECHANICS
  -- Sane neovim defaults!

  local opt = require'_utils'.opt

  -- ## Tab options

  -- Set indents to two spaces wide
  local indent = 2
  -- Use spaces instead of tabs
  opt('b', 'expandtab', true)
  -- Size of an indent
  opt('b', 'shiftwidth', indent)
  -- Insert indents automatically
  opt('b', 'smartindent', true)
  -- Tabbing mid space keeps indentation
  opt('b', 'tabstop', indent)
  vim.o.smarttab = true
  -- Copy level of indendation from previous line
  vim.o.autoindent = true

  -- ## Search options

  -- Search incrementally, live results as we type
  -- *TODO* honestly `telescope.nvim` is much better than built in search, we bind that to `/` or what?
  vim.o.incsearch = true
  -- Ignorecase in search unless we put in cases
  vim.o.ignorecase = true
  vim.o.smartcase = true
  -- Highlight search results
  vim.o.hlsearch = true

  -- ## Text

  -- Enable wrapping of text and breaking of indent on that wrapped line
  vim.o.wrap = true
  vim.o.breakindent = true

  -- ## Gutter

  -- Relative line numbers
  opt('w', 'rnu', true)
  -- But show current line number
  opt('w', 'number', true)
  -- Have errors show on the number column
  opt('w', 'scl', 'number')

  -- ## Misc

  -- Bind vim clipboard to system clipboard
  vim.o.clipboard = 'unnamedplus'
  -- Using join space `J` inserts no double spaces after a dot
  vim.o.joinspaces = false
  -- Make it so we can easily traverse word wrappings
  -- vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
  -- JK for escape
  vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
  -- Neovim nightly feature to briefly show highlight on yank
  vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
  -- *TODO* IDK MARKDOWN PREVIEW NOT WORKING
  -- vim.g.mkdp_auto_start = 0
