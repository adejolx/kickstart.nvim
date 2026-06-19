return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }

    local ts_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()

    ---@diagnostic disable-next-line: missing-fields
    require('Comment').setup {
      pre_hook = function(ctx)
        local ft = vim.bo.filetype

        local use_ts_context = {
          javascriptreact = true,
          typescriptreact = true,
          vue = true,
          svelte = true,
          html = true,
          astro = true,
        }

        if use_ts_context[ft] then return ts_hook(ctx) or vim.bo.commentstring end

        return vim.bo.commentstring
      end,
    }
  end,
}
