return {
  'echasnovski/mini.files',
  version = '*',
  keys = {
    {
      '<leader>md',
      function()
        if not require('mini.files').close() then require('mini.files').open(nil, false) end
      end,
      desc = 'Open mini.files (Current [D]ir)',
    },
    {
      '<leader>mf',
      function()
        if not require('mini.files').close() then require('mini.files').open(vim.api.nvim_buf_get_name(0)) end
      end,
      desc = 'Open mini.files (Current [F]ile)',
    },
  },
  config = function()
    local MiniFiles = require 'mini.files'

    MiniFiles.setup {
      mappings = {
        go_in = '',
        go_in_plus = '<c-l>',
        go_out = '',
        go_out_plus = '<c-h>',
      },
    }

    -- open selection in split
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        local entry = MiniFiles.get_fs_entry()

        -- Noop if the cursor is on a directory.
        if not entry or entry.fs_type == 'directory' then return end

        -- Make a new window and set it as target.
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in()
        MiniFiles.close()
      end

      local desc = 'Split ' .. string.sub(direction, 12)
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    -- open selection in new tab
    local map_tab = function(buf_id, lhs)
      local rhs = function()
        local entry = MiniFiles.get_fs_entry()

        -- Noop if the cursor is on a directory.
        if not entry or entry.fs_type == 'directory' then return end

        -- Make a new tab and set its window as target.
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
          vim.cmd 'tabnew'
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in()
        MiniFiles.close()
      end

      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = 'Open in new tab' })
    end

    local reveal_in_finder = function(buf_id, lhs)
      vim.keymap.set('n', lhs, function()
        local entry = MiniFiles.get_fs_entry()
        if not entry then return end

        local path = entry.path

        if entry.fs_type == 'directory' then
          vim.fn.jobstart({ 'open', path }, { detach = true })
        else
          vim.fn.jobstart({ 'open', '-R', path }, { detach = true })
        end
      end, { buffer = buf_id, desc = 'Reveal in Finder' })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        reveal_in_finder(buf_id, 'go')

        map_split(buf_id, 'gs', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
        map_tab(buf_id, 'gt')
      end,
    })

    -- show relative line number
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowUpdate',
      callback = function(args) vim.wo[args.data.win_id].relativenumber = true end,
    })
  end,
}
