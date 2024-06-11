local keymap = vim.keymap

keymap.set('i', 'jk', '<esc>', { desc = 'Exit insert mode' })
keymap.set('n', '<s-h>', '_', { desc = 'Goto first character in line' })
keymap.set('n', '<s-l>', '$', { desc = 'Goto last character in line' })
keymap.set('n', 'j', 'gj', { desc = 'Down one line' })
keymap.set('n', 'k', 'gk', { desc = 'Up one line' })
