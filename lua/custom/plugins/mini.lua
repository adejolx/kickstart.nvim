-- Recent mini.nvim module configuration.

require('mini.jump2d').setup()
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', MiniJump2d.start, { desc = 'Jump to a location' })

-- Show only buffers that are currently displayed in a window.
local function refresh_tabline_buffer(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return end

  local was_listed = vim.b[buf].kickstart_tabline_buflisted
  if was_listed == nil then
    was_listed = vim.bo[buf].buflisted
    vim.b[buf].kickstart_tabline_buflisted = was_listed
  end

  if was_listed then vim.bo[buf].buflisted = #vim.fn.win_findbuf(buf) > 0 end
end

local function refresh_tabline_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    refresh_tabline_buffer(buf)
  end
end

require('mini.tabline').setup()
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufHidden' }, {
  desc = 'Keep hidden buffers out of the tabline',
  callback = function(args) vim.schedule(function() refresh_tabline_buffer(args.buf) end) end,
})
refresh_tabline_buffers()
