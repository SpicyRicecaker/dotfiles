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
  -- require '_nvim-tree'
end)()
