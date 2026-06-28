local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- Recommended if you use <leader> mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap.set('i', 'jk', '<esc>', { desc = 'Exit insert mode' })

keymap.set('n', '<s-h>', '_', { desc = 'Go to first non-blank character in line' })
keymap.set('n', '<s-l>', '$', { desc = 'Go to last character in line' })

keymap.set('n', 'j', 'gj', { noremap = true, desc = 'Move down by visual line' })
keymap.set('n', 'k', 'gk', { noremap = true, desc = 'Move up by visual line' })

keymap.set('n', '<c-u>', '<c-u>zz', { noremap = true, desc = 'Half-page up and center' })
keymap.set('n', '<c-d>', '<c-d>zz', { noremap = true, desc = 'Half-page down and center' })

keymap.set('n', '<leader>a', 'ggVG', { noremap = true, silent = true, desc = 'Select all' })

-- Save / quit
keymap.set(
  'n',
  '<leader>w',
  '<cmd>w<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Save file',
  })
)

keymap.set(
  'n',
  '<leader>Q',
  '<cmd>q<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Quit window',
  })
)

-- Clear search highlight
keymap.set(
  'n',
  '<leader>nh',
  '<cmd>nohlsearch<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Clear search highlights',
  })
)

-- Keep cursor centered when searching
keymap.set(
  'n',
  'n',
  'nzzzv',
  vim.tbl_extend('force', opts, {
    desc = 'Next search result and center',
  })
)

keymap.set(
  'n',
  'N',
  'Nzzzv',
  vim.tbl_extend('force', opts, {
    desc = 'Previous search result and center',
  })
)

-- Window navigation
keymap.set(
  'n',
  '<c-h>',
  '<c-w>h',
  vim.tbl_extend('force', opts, {
    desc = 'Move to left window',
  })
)

keymap.set(
  'n',
  '<c-j>',
  '<c-w>j',
  vim.tbl_extend('force', opts, {
    desc = 'Move to lower window',
  })
)

keymap.set(
  'n',
  '<c-k>',
  '<c-w>k',
  vim.tbl_extend('force', opts, {
    desc = 'Move to upper window',
  })
)

keymap.set(
  'n',
  '<c-l>',
  '<c-w>l',
  vim.tbl_extend('force', opts, {
    desc = 'Move to right window',
  })
)

-- Resize windows
keymap.set(
  'n',
  '<leader>=',
  '<cmd>resize +5<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Increase window height',
  })
)

keymap.set(
  'n',
  '<leader>-',
  '<cmd>resize -5<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Decrease window height',
  })
)

keymap.set(
  'n',
  '<leader>>',
  '<cmd>vertical resize +5<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Increase window width',
  })
)

keymap.set(
  'n',
  '<leader><',
  '<cmd>vertical resize -5<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Decrease window width',
  })
)

-- Buffer navigation
keymap.set(
  'n',
  '<leader>bn',
  '<cmd>bnext<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Next buffer',
  })
)

keymap.set(
  'n',
  '<leader>bp',
  '<cmd>bprevious<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Previous buffer',
  })
)

keymap.set(
  'n',
  '<leader>bd',
  '<cmd>bdelete<cr>',
  vim.tbl_extend('force', opts, {
    desc = 'Delete buffer',
  })
)

-- Better visual indenting: stay in visual mode after indent
keymap.set(
  'v',
  '<',
  '<gv',
  vim.tbl_extend('force', opts, {
    desc = 'Indent left and reselect',
  })
)

keymap.set(
  'v',
  '>',
  '>gv',
  vim.tbl_extend('force', opts, {
    desc = 'Indent right and reselect',
  })
)

-- Move selected lines up/down
keymap.set(
  'v',
  'J',
  ":m '>+1<cr>gv=gv",
  vim.tbl_extend('force', opts, {
    desc = 'Move selection down',
  })
)

keymap.set(
  'v',
  'K',
  ":m '<-2<cr>gv=gv",
  vim.tbl_extend('force', opts, {
    desc = 'Move selection up',
  })
)

-- Paste over selection without replacing your yank register
keymap.set(
  'x',
  '<leader>p',
  '"_dP',
  vim.tbl_extend('force', opts, {
    desc = 'Paste without yanking replaced text',
  })
)

-- Delete without yanking
keymap.set(
  { 'n', 'v' },
  '<leader>d',
  '"_d',
  vim.tbl_extend('force', opts, {
    desc = 'Delete without yanking',
  })
)

-- Keep cursor in place when joining lines
keymap.set(
  'n',
  'J',
  'mzJ`z',
  vim.tbl_extend('force', opts, {
    desc = 'Join lines and keep cursor position',
  })
)

-- Diagnostics, if you use built-in LSP
keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
  desc = 'Show line diagnostics',
})

keymap.set('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Previous diagnostic',
})

keymap.set('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Next diagnostic',
})

keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, {
  desc = 'Open diagnostics list',
})
