require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    rust = {
      -- Rustfmt
      function()
        return {exe = "rustfmt", args = {"--emit=stdout"}, stdin = true}
      end
    },
    lua = {
      -- luafmt
      function()
        return {exe = "lua-format", args = {"--indent-width", 2}, stdin = true}
      end
    },
    svelte = {
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    }
  }
})

vim.api.nvim_set_keymap('n', 'gf', '<cmd>Format<CR>', {silent = true})
