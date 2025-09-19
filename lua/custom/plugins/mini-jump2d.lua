return {
  'echasnovski/mini.jump2d',
  version = '*',
  config = function()
    require('mini.jump2d').setup {
      view = {
        dim = true,
      },
    }
  end,
}
