-- # LSP
-- Deals with language servers using built-in 0.5.0 lsp

-- ## QOL Changes

-- Allow modified buffers? idk
vim.o.hidden = true
-- Update time (ms) used for time before cursor hold event is triggered and swap is saved to disk
vim.o.ut = 300
-- Autowrite file on focus change, quit, etc.
vim.o.awa = true
-- Different ways to auto save to try to get rust analyzer to work... TL;DR it it didn't work
-- *TODO* rust-analyzer is still broken can't be saved on change rip
-- cmd'autocmd TextChanged,TextChangedI <buffer>,html silent write'
-- cmd'autocmd TextChanged,TextChangedI  silent write'
-- Make messages smaller
-- vim.cmd[[set shortmess+=c]]
-- Show diagnostics on mouse hold
vim.cmd'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'
-- Completion menu
vim.cmd'set completeopt=menuone,noinsert,noselect'

-- ## Servers

-- I guess we initiate all lsp, pass that into functions, and go from there

local lspconfig = require 'lspconfig'
local completion = require 'completion'

-- ## LSPSTATUS

local lsp_status = require'lsp-status'
lsp_status.register_progress()
lsp_status.config{
  indicator_hint = '!',
  status_symbol = 'nvim',
  indicator_errors = 'E',
  indicator_warnings = 'W',
  indicator_info = 'i',
  indicator_ok = 'Ok',
}

lspconfig.util.default_config = vim.tbl_extend(
"force",
lspconfig.util.default_config,
{on_attach = function ()
  completion.on_attach()
end;
capabilities = lsp_status.capabilities}

)

require'lsp/_lua'
lspconfig.textlab.setup{}
lspconfig.tsserver.setup{}
lspconfig.rust_analyzer.setup{
  cargo = {
    allFeatures =  true
  }
}

local function LspStatus()
  if #vim.lsp.buf_get_clients() > 0 then
    return lsp_status.status()
  end
  return ''
end

-- ## Status line config
local lualine = require('lualine')
lualine.theme = 'gruvbox_material'
lualine.separator = '|'
lualine.sections = {
  lualine_a = { 'mode' },
  lualine_b = { 'branch' },
  lualine_c = { 'filename', LspStatus },
  lualine_x = { 'encoding', 'fileformat', 'filetype' },
  lualine_y = { 'progress' },
  lualine_z = { 'location'  },
  lualine_diagnostics = {  }
}

lualine.inactive_sections = {
  lualine_a = {  },
  lualine_b = {  },
  lualine_c = { 'filename' },
  lualine_x = { 'location' },
  lualine_y = {  },
  lualine_z = {   }
}
lualine.extensions = { 'fzf' }
lualine.status()


-- ## KEYBINDS
-- c-] to view definition
vim.api.nvim_set_keymap('n', '<c-]>', '<cmd>vim.lsp.buf.definition()<CR>', {noremap = true})
-- K to 'hover'
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
-- gD to check the implementation
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})
-- c-k to help signature
vim.api.nvim_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true})
-- 1gD to check type definition
vim.api.nvim_set_keymap('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true})
-- gr to check references
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})
-- g0 to check document symbol
vim.api.nvim_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {noremap = true})
-- gW to check workspace symbol
vim.api.nvim_set_keymap('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {noremap = true})
-- gd to check declaration
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true})
-- Autocomplete w/ Ctrl-x Ctrl-o
vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- *TODO* forgot what this did
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
function _G.smart_tab_n()
  return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end
function _G.smart_tab_p()
  return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

-- Tab completions?
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab_n()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_tab_p()', {expr = true, noremap = true})

