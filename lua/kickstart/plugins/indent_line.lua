-- Add indentation guides and highlight the current code scope.

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help ibl`
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }

require('ibl').setup {
  indent = {
    char = '│',
    tab_char = '│',
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    show_exact_scope = true,
  },
  exclude = {
    buftypes = { 'help', 'nofile', 'quickfix', 'terminal', 'prompt' },
    filetypes = {
      'alpha',
      'dashboard',
      'lazy',
      'mason',
      'neo-tree',
      'notify',
      'TelescopePrompt',
    },
  },
}

vim.keymap.set('n', '<leader>ui', function()
  require('ibl').toggle()
end, { desc = 'Toggle indent guides' })
