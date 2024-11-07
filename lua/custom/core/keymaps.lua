local keymap = vim.keymap

keymap.set('i', 'jk', '<esc>', { desc = 'Exit insert mode' })
keymap.set('n', '<s-h>', '_', { desc = 'Goto first character in line' })
keymap.set('n', '<s-l>', '$', { desc = 'Goto last character in line' })
keymap.set('n', 'j', 'gj', { noremap = true, desc = 'Down one line' })
keymap.set('n', 'k', 'gk', { noremap = true, desc = 'Up one line' })
keymap.set('n', '<c-u>', '<c-u>zz', { noremap = true, desc = 'Up one line' })
keymap.set('n', '<c-d>', '<c-d>zz', { noremap = true, desc = 'Up one line' })
