return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local api = require 'nvim-tree.api'

    local function my_on_attach(bufnr)
      api.config.mappings.default_on_attach(bufnr)
    end

    require('nvim-tree').setup {
      hijack_cursor = true,
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 40,
        float = {
          enable = true,
          open_win_config = {
            width = 80,
          },
        },
        number = true,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        highlight_modified = 'all',
        indent_markers = { enable = true },
        icons = {
          web_devicons = {
            folder = {
              enable = true,
            },
          },
        },
      },
      on_attach = my_on_attach,
      modified = { enable = true },
      update_focused_file = { enable = true },
      live_filter = {
        always_show_folders = false,
      },
    }

    -- Keymaps
    vim.keymap.set('n', '\\', api.tree.toggle, { desc = 'NvimTree Toggle', noremap = true, silent = true, nowait = true })
  end,
}
