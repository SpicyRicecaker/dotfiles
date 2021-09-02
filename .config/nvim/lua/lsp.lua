local function t(str)
  -- Adjust boolean arguments as needed
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

--[[ " function! s:check_back_space() abort
" 	let col = col('.') - 1
" 	return !col || getline('.')[col - 1]  =~# '\s'
" endfunction ]]

local function check_back_space()
  -- Get col of cursor
  local col = vim.api.nvim_win_get_cursor(0)[2]
  -- So if we're on call 0, there can be no backspace?
  return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end

function _G.smart_tab()
  return vim.fn.pumvisible() == 1 and t'<C-n>' or check_back_space() and t'<Tab>' or vim.fn['coc#refresh']()
end

function _G.smart_shift_tab()
  return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<C-h>'
end

function _G.smart_enter()
  return vim.fn.pumvisible() == 1 and vim.fn['coc#_select_confirm']() or t'<C-g>' .. 'u' .. t'<CR>' .. t'<c-r>' .. '=coc#on_enter()' .. t'<CR>'
end

function _G.smart_show_documentation()
  local filetype = vim.bo.filetype

  if vim.call'coc#rpc#ready' then
    vim.fn['CocActionAsync']('doHover')
  elseif filetype == 'vim' or filetype == 'help' then
    vim.api.nvim_command('h ' .. vim.fn.expand'<cword>')
  else
    vim.api.nvim_command('!' .. vim.bo.keywordprg .. ' ' .. vim.fn.expand'<cword>')
  end
end

function _G.scroll_floating_f()
  return vim.call'coc#float#has_scroll' and vim.fn['coc#float#scroll'](1) or t'<C-f>'
end

function _G.scroll_floating_b()
  return vim.call'coc#float#has_scroll' and vim.fn['coc#float#scroll'](0) or t'<C-b>'
end

function _G.scroll_floating_r()
  return vim.call'coc#float#has_scroll' and t'<C-r>' .. '=coc#float#scroll(1)' .. t'<CR>' or t'<Right>'
end

function _G.scroll_floating_l()
  return vim.call'coc#float#has_scroll' and t'<C-r>' .. '=coc#float#scroll(0)' .. t'<CR>' or t'<Left>'
end

local function load ()
  require'autosave'.setup{
    execution_message = ''
  }
  vim.o.shortmess = vim.o.shortmess .. 'c'
  local m = vim.api.nvim_set_keymap
 
  m('n', '<C-f>', 'v:lua.scroll_floating_f()', {expr = true, silent = true, noremap = true})
  m('n', '<C-b>', 'v:lua.scroll_floating_b()', {expr = true, silent = true, noremap = true})
  m('i', '<C-f>', 'v:lua.scroll_floating_r()', {expr = true, silent = true, noremap = true})
  m('i', '<C-b>', 'v:lua.scroll_floating_l()', {expr = true, silent = true, noremap = true})
  m('v', '<C-f>', 'v:lua.scroll_floating_f()', {expr = true, silent = true, noremap = true})
  m('v', '<C-b>', 'v:lua.scroll_floating_b()', {expr = true, silent = true, noremap = true})

  -- Use K to show documentation in preview window.
  m('n', 'K', '<Cmd>lua smart_show_documentation()<CR>', {silent = true, noremap = true})

  -- Use tab for trigger completion with characters ahead and navigate.
  -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  -- other plugin before putting this into your config.
  -- inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  m('i', '<CR>', 'v:lua.smart_enter()', {expr = true, silent = true, noremap = true})
  m('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, silent = true, noremap = true})
  -- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  m('i', '<S-Tab>', 'v:lua.smart_shift_tab()', {expr = true, silent = true, noremap = true})

  -- m('i', '<c-space>', '<Cmd>call coc#refresh()<CR>', {noremap = true, silent = true})
  m('i', '<c-space>', 'coc#refresh()', {expr = true, noremap = true, silent = true})

  -- Use `[g` and `]g` to navigate diagnostics
  -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  m('n', '[g', '<Plug>(coc-diagnostic-prev)', {silent = true})
  m('n', ']g', '<Plug>(coc-diagnostic-next)', {silent = true})
  -- GoTo code navigation.
  m('n', 'gd', '<Plug>(coc-definition)', {silent = true})
  m('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
  m('n', 'gi', '<Plug>(coc-type-implementation)', {silent = true})
  m('n', 'gr', '<Plug>(coc-references)', {silent = true})

  -- Symbol renaming.
  m('n', '<leader>rn', '<Plug>(coc-rename)', {})

  -- Formatting selected code.
  -- Rust-analyzer doesn't support selection format so these are pretty useless
  -- m('x', '<leader>f', '<Plug>(coc-format-selected)', {})
  -- m('n', '<leader>f', '<Plug>(coc-format-selected)', {})
  m('n', '<leader>h', "<Cmd>call CocAction('format')<CR>", {})

  -- Remap keys for applying codeAction to the current buffer.
  m('n', '<leader>ac', '<Plug>(coc-codeaction)', {})
  -- Apply AutoFix to problem on the current line.
  m('n', '<leader>qf', '<Plug>(coc-fix-current)', {})
  -- Applying codeAction to the selected region.
  --  Example: `<leader>aap` for current paragraph
  --  Changed from: a
  m('x','<leader>.','<Plug>(coc-codeaction-selected)', {})
  m('n','<leader>.','<Plug>(coc-codeaction-selected)', {})

  -- Map function and class text objects
  -- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  m('x','if','<Plug>(coc-funcobj-i)', {})
  m('o','if','<Plug>(coc-funcobj-i)', {})
  m('x','af','<Plug>(coc-funcobj-a)', {})
  m('o','af','<Plug>(coc-funcobj-a)', {})
  m('x','ic','<Plug>(coc-classobj-i)', {})
  m('o','ic','<Plug>(coc-classobj-i)', {})
  m('x','ac','<Plug>(coc-classobj-a)', {})
  m('o','ac','<Plug>(coc-classobj-a)', {})

  -- Use CTRL-S for selections ranges.
  -- Requires 'textDocument/selectionRange' support of language server.
  m('n', '<C-s>', '<Plug>(coc-range-select)', {silent = true})
  m('x', '<C-s>', '<Plug>(coc-range-select)', {silent = true})

  -- Mappings for CoCList
  -- Show all diagnostics.
  m('n', '<space>a',':<C-u>CocList diagnostics<CR>', {silent = true, nowait = true})
  -- Manage extensions.
  m('n', '<space>e',':<C-u>CocList extensions<CR>', {silent = true, nowait = true})
  -- Show commands.
  m('n', '<space>c',':<C-u>CocList commands<CR>', {silent = true, nowait = true})
  -- Find symbol of current document.
  m('n', '<space>o',':<C-u>CocList outline<CR>', {silent = true, nowait = true})
  -- Search workspace symbols.
  m('n', '<space>s',':<C-u>CocList -I symbols<CR>', {silent = true, nowait = true})
  -- Do default action for next item.
  m('n', '<space>j', ':<C-u>CocNext<CR>', {silent = true, nowait = true})
  -- Do default action for previous item.
  m('n', '<space>k', ':<C-u>CocPrev<CR>', {silent = true, nowait = true})
  -- Resume latest coc list.
  m('n', '<space>p', ':<C-u>CocListResume<CR> ', {silent = true, nowait = true})
end

load()
