
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- <space>ca -> <space>.
  buf_set_keymap('n', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>h', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --[[ -- Debug mappings
  buf_set_keymap('n', '<F5>', "<cmd>lua require'dap'.continue()<CR>", opts)
  buf_set_keymap('n', '<F10>', "<cmd>lua require'dap'.step_over()<CR>", opts)
  buf_set_keymap('n', '<F11>', "<cmd>lua require'dap'.step_into()<CR>", opts)
  buf_set_keymap('n', '<F12>', "<cmd>lua require'dap'.step_out()<CR>", opts)
  buf_set_keymap('n', '<Leader>b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
  buf_set_keymap('n', '<Leader>B', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
  buf_set_keymap('n', '<Leader>lp', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
  buf_set_keymap('n', '<Leader>dr', "<cmd>lua require'dap'.repl.open()<CR>", opts)
  buf_set_keymap('n', '<Leader>dl', "<cmd>lua require'dap'.run_last()<CR>", opts)
  -- Stop current debug session
  buf_set_keymap('n', '<Leader>dc', "<cmd>lua require'dap'.disconnect()<CR>", opts)
  -- Terminate debug session
  buf_set_keymap('n', '<Leader>dt', "<cmd>lua require'dap'.disconnect()<CR><cmd>lua require'dap'.close()<CR>", opts)

  -- Add ui
  require'dapui'.setup{} ]]
end

(function ()
  -- Completions
  local cmp = require'cmp'

  cmp.setup {
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' }
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        -- behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    }
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local lspconfig = require'lspconfig'

  -- Rust
  require'rust-tools'.setup{
    server = {
      capabiliities = capabilities,
      on_attach = on_attach,
      cargo = { allFeatures = true },
      checkOnSave = { command = 'clippy' }
    }
  }

  -- Lua
  local sumneko_binary_path = vim.fn.exepath('lua-language-server')
  local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')
  -- Not sure if lua-dev is actually doing anything lol
  lspconfig.sumneko_lua.setup{
      capabiliities = capabilities,
      on_attach = on_attach,
      cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = (function ()
              local runtime_path = vim.split(package.path, ';')
              table.insert(runtime_path, "lua/?.lua")
              table.insert(runtime_path, "lua/?/init.lua")
              return runtime_path
            end)(),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim', 'use'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
  }

  -- Setup dap
  --[[ local dap = require('dap')
  dap.adapters.cppdbg = {
    type = 'executable',
    command = '/home/spicy/git/cpptools-linux/extension/bin/OpenDebugAD7',
  }
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
    }
  } ]]
end)()
