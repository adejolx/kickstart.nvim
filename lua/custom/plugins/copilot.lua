return {
  'github/copilot.vim',
  event = 'InsertEnter',

  init = function() vim.g.copilot_no_tab_map = true end,

  config = function()
    vim.keymap.set('i', '<C-l>', 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
      desc = 'Accept Copilot suggestion',
    })
  end,
}
