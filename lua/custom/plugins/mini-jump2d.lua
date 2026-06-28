return {
  'echasnovski/mini.jump2d',
  version = '*',
  config = function()
    require('mini.jump2d').setup {
      mappings = {
        start_jumping = '<leader>j',
      },
      view = {
        dim = true,
      },
    }
  end,
}
