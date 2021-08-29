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
	return vim.fn.pumvisible() == 1 and t'<C-n>' or check_back_space() and t'<Tab>' or vim.fn'coc#refresh'()
end

function _G.smart_shift_tab()
	return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<C-h>'
end

local function load ()
	require'autosave'.setup{
		execution_message = ''
	}
	local m = vim.api.nvim_set_keymap

	-- Use tab for trigger completion with characters ahead and navigate.
	-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	-- other plugin before putting this into your config.
	-- inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
	m('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
	-- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	m('i', '<S-Tab>', 'v:lua.smart_shift_tab()', {expr = true, noremap = true})

	m('i', '<c-space>', 'coc#refresh', {expr = true})

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
	m('x', '<leader>f', '<Plug>(coc-format-selected)', {})
	m('n', '<leader>f', '<Plug>(coc-format-selected)', {})

	-- Remap keys for applying codeAction to the current buffer.
	m('n', '<leader>ac', '<Plug>(coc-codeaction)', {})
	-- Apply AutoFix to problem on the current line.
	m('n', '<leader>qf', '<Plug>(coc-fix-current)', {})
	-- Applying codeAction to the selected region.
	--  Example: `<leader>aap` for current paragraph
	m('x','<leader>a','<Plug>(coc-codeaction-selected)', {})
	m('n','<leader>a','<Plug>(coc-codeaction-selected)', {})

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
