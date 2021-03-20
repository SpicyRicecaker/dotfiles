-- If we're using the VSCode Extension
if vim.g.vscode == 1 then
  -- Bind vim clipboard to system clipboard
  vim.o.clipboard = 'unnamedplus'
  -- Make j and k travese folds
  -- vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true, silent = true})
  -- Highlight text on yank and stuff
  vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
  -- Smartcase search
  vim.o.ignorecase = true
  vim.o.smartcase = true
else
  -- Call our init function
  (function()
    -- First load plugins
    require '_plugins'
    -- Then load sane default settings
    require '_mechanics'
    -- Then load colorscheme
    require '_colorscheme'
    -- Then load telescope (fuzzy find)
    require '_telescope'
    -- Then load lsp
    require '_lsp'
    -- Then load statusline
    require '_statusline'
    -- Then load formatter
    require '_formatter'
    -- Then load tree
    require '_nvim-tree'
  end)()
end
