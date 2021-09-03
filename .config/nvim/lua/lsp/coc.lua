local function t(str)
  -- Adjust boolean arguments as needed
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.coc = {
  -- Checks if there is a whitespace behind the cursor
  check_back_space = function ()
    -- Get col of cursor
    local col = vim.api.nvim_win_get_cursor(0)[2]
    -- If cursor on col 0, there is no backspace, else there is
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
  end,

  -- If completion is visible, select next option, otherwise if there is a backspace just insert tab, otherwise refresh completions
  tab = function (self)
    return vim.fn.pumvisible() == 1 and t'<C-n>' or self.check_back_space() and t'<Tab>' or vim.fn['coc#refresh']()
  end,

  -- Like `tab` except select previous option
  shift_tab = function ()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<C-h>'
  end,

  -- If completion is visible, select the completion option, otherwise conveniently makes sure that cursor indent doesn't start at beginning of the line
  enter = function ()
    return vim.fn.pumvisible() == 1 and vim.fn['coc#_select_confirm']() or t'<C-g>' .. 'u' .. t'<CR>' .. t'<c-r>' .. '=coc#on_enter()' .. t'<CR>'
  end,

  -- Similar to the hover function in vscode
  show_doc = function ()
    local filetype = vim.bo.filetype

    -- If lsp is attached
    if vim.call'coc#rpc#ready' then
      -- Hover function
      vim.fn['CocActionAsync']('doHover')
    -- Otherwise if we're in a help file
    elseif filetype == 'vim' or filetype == 'help' then
      -- Goto link
      vim.api.nvim_command('h ' .. vim.fn.expand'<cword>')
    else
      -- TODO idk wat this does
      vim.api.nvim_command('!' .. vim.bo.keywordprg .. ' ' .. vim.fn.expand'<cword>')
    end
  end,

  -- In normal mode, if there is a floating window, scroll down, otherwise return the move screen down action
  scr_f = function ()
    return vim.call'coc#float#has_scroll' == 1 and vim.fn['coc#float#scroll'](1) or t'<C-f>'
  end,

  -- In normal mode, if there is a floating window, scroll up, otherwise return the move screen up action
  scr_b = function ()
    return vim.call'coc#float#has_scroll' == 1 and vim.fn['coc#float#scroll'](0) or t'<C-b>'
  end,

  -- In insert mode, if there is a floating window, scroll right, otherwise return the move cursor right action
  scr_r = function()
    return vim.call'coc#float#has_scroll' == 1 and t'<C-r>' .. '=coc#float#scroll(1)' .. t'<CR>' or t'<Right>'
  end,

  -- In insert mode, if there is a floating window, scroll left, otherwise return the move cursor left action
  scr_l = function()
    return vim.call'coc#float#has_scroll' == 1 and t'<C-r>' .. '=coc#float#scroll(0)' .. t'<CR>' or t'<Left>'
  end
}

local function coc_load ()
  vim.o.shortmess = vim.o.shortmess .. 'c'
  local m = vim.api.nvim_set_keymap

  m('n', '<C-f>', 'v:lua.coc.scr_f()', {expr = true, silent = true, noremap = true, nowait = true})
  m('n', '<C-b>', 'v:lua.coc.scr_b()', {expr = true, silent = true, noremap = true, nowait = true})
  m('i', '<C-f>', 'v:lua.coc.scr_r()', {expr = true, silent = true, noremap = true, nowait = true})
  m('i', '<C-b>', 'v:lua.coc.scr_l()', {expr = true, silent = true, noremap = true, nowait = true})
  m('v', '<C-f>', 'v:lua.coc.scr_f()', {expr = true, silent = true, noremap = true, nowait = true})
  m('v', '<C-b>', 'v:lua.coc.scr_b()', {expr = true, silent = true, noremap = true, nowait = true})

  -- Use K to show documentation in preview window.
  m('n', 'K', '<Cmd>lua coc.show_doc()<CR>', {silent = true, noremap = true})

  -- Use tab for trigger completion with characters ahead and navigate.
  -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  -- other plugin before putting this into your config.
  -- inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  m('i', '<CR>', 'v:lua.coc.enter()', {expr = true, silent = true, noremap = true})
  m('i', '<Tab>', 'v:lua.coc.tab()', {expr = true, silent = true, noremap = true})
  -- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  m('i', '<S-Tab>', 'v:lua.coc.shift_tab()', {expr = true, silent = true, noremap = true})

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

coc_load()
