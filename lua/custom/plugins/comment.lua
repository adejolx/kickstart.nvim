return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    -- 1. Configure the context-commentstring plugin FIRST
    require('ts_context_commentstring').setup {
      enable_autocmd = false, -- This is the magic line that kills the error
    }

    local comment = require 'Comment'
    local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'

    -- 2. Enable comment with the pre_hook
    comment.setup {
      pre_hook = ts_context_commentstring.create_pre_hook(),
    }
  end,
}
