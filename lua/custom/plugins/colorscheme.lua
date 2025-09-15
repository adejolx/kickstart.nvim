return {
  'Skardyy/makurai-nvim',
  config = function()
    -- you don't have to call setup
    require('makurai').setup {
      increase_contrast = true,
      bordered = true,
      transparent = false,
    }

    vim.cmd.colorscheme 'makurai_dark'
  end,
}
