-- Recent mini.nvim module configuration.

require('mini.jump2d').setup()
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', MiniJump2d.start, { desc = 'Jump to a location' })

require('mini.tabline').setup()
