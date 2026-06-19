return {
  'adejolx-kora/lowbeam.nvim',
  priority = 1000,
  config = function()
    require('lowbeam').setup {}

    vim.cmd.colorscheme 'lowbeam-day'
  end,
}
