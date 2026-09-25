-- mini.files is a small, editable file explorer from echasnovski.
-- https://github.com/nvim-mini/mini.nvim/tree/main#mini-files

local MiniFiles = require 'mini.files'
local ignored_by_directory = {}
vim.g.mini_files_show_git_ignored = false

vim.api.nvim_set_hl(0, 'MiniFilesIgnored', { link = 'Comment' })

local function ignored_paths_in(directory)
  if ignored_by_directory[directory] then return ignored_by_directory[directory] end

  local ignored = {}
  ignored_by_directory[directory] = ignored
  if vim.fn.executable 'git' == 0 then return ignored end

  -- Do not restrict this to directories: worktrees use a `.git` file.
  local git_directory = vim.fs.find('.git', { path = directory, upward = true })[1]
  if not git_directory then return ignored end

  local root = vim.fs.dirname(git_directory)
  local paths = {}
  for name, fs_type in vim.fs.dir(directory) do
    local path = vim.fs.joinpath(directory, name)
    local relative_path = vim.fs.relpath(root, path)
    if relative_path then paths[#paths + 1] = relative_path .. (fs_type == 'directory' and '/' or '') end
  end
  if #paths == 0 then return ignored end

  -- One Git process per displayed directory, instead of one per entry.
  local process = vim.system({ 'git', '-C', root, 'check-ignore', '--stdin', '-z' }, { text = true, stdin = true })
  process:write(table.concat(paths, '\0') .. '\0')
  process:write(nil)
  local result = process:wait()

  for relative_path in (result.stdout or ''):gmatch '[^%z]+' do
    ignored[vim.fs.normalize(vim.fs.joinpath(root, relative_path))] = true
  end
  return ignored
end

local function is_git_ignored(path)
  -- Check the parent listing so directory entries are checked themselves.
  local directory = vim.fs.dirname(path)
  return ignored_paths_in(directory)[vim.fs.normalize(path)] == true
end

local function git_filter(fs_entry)
  return vim.g.mini_files_show_git_ignored or not is_git_ignored(fs_entry.path)
end

local function toggle_files(path, use_latest)
  if MiniFiles.close() == nil then MiniFiles.open(path, use_latest) end
end

local function current_entry()
  local entry = MiniFiles.get_fs_entry()
  if not entry or not entry.path then
    vim.notify('No file or folder under the cursor', vim.log.levels.WARN)
    return nil
  end
  return entry.path
end

local function copy_path(relative)
  local path = current_entry()
  if not path then return end

  local value = relative and vim.fn.fnamemodify(path, ':.') or path
  vim.fn.setreg(vim.v.register, value)
  vim.notify(('Copied %s path: %s'):format(relative and 'relative' or 'absolute', value))
end

local function open_in_os()
  local path = current_entry()
  if path then vim.ui.open(path) end
end

local function map_split(buf, lhs, direction)
  vim.keymap.set('n', lhs, function()
    local target_window = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(target_window, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in { close_on_file = true }
  end, { buffer = buf, desc = 'Open in ' .. direction .. ' split' })
end

MiniFiles.setup {
  content = {
    filter = git_filter,
    highlight = function(fs_entry)
      if is_git_ignored(fs_entry.path) then return 'MiniFilesIgnored' end
      return MiniFiles.default_highlight(fs_entry)
    end,
  },
  mappings = {
    -- Open files and close the explorer; use `L` to keep it open.
    go_in = 'L',
    go_in_plus = 'l',
  },
  options = {
    permanent_delete = false,
    use_as_default_explorer = true,
    -- Let supported LSP clients update imports and references after renames.
    lsp_timeout = 1000,
  },
  windows = {
    -- QoL 1: preview the selected file or directory.
    preview = true,
    width_preview = 45,
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = { 'MiniFilesExplorerOpen', 'MiniFilesActionCreate', 'MiniFilesActionDelete', 'MiniFilesActionRename', 'MiniFilesActionMove' },
  desc = 'Refresh cached Git ignored paths',
  callback = function() ignored_by_directory = {} end,
})

-- Open at the current file by default; use `\` as a quick toggle.
vim.keymap.set('n', '\\', function() toggle_files(vim.api.nvim_buf_get_name(0), false) end, { desc = 'Reveal current file', silent = true })
vim.keymap.set('n', '<leader>\\', function() toggle_files() end, { desc = 'Toggle file explorer' })

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  desc = 'Configure mini.files actions',
  callback = function(args)
    local buf = args.data.buf_id

    -- Open a file or folder with the consumer's default OS application.
    vim.keymap.set('n', 'gX', open_in_os, { buffer = buf, desc = 'Open with OS' })
    vim.keymap.set('n', '<CR>', function() MiniFiles.go_in { close_on_file = true } end, { buffer = buf, desc = 'Open and close explorer' })
    map_split(buf, '<C-s>', 'belowright horizontal')
    map_split(buf, '<C-v>', 'belowright vertical')

    -- Copy the selected entry to the active register in either path format.
    vim.keymap.set('n', 'gy', function() copy_path(false) end, { buffer = buf, desc = 'Yank absolute path' })
    vim.keymap.set('n', 'gY', function() copy_path(true) end, { buffer = buf, desc = 'Yank relative path' })

    vim.keymap.set('n', 'gI', function()
      vim.g.mini_files_show_git_ignored = not vim.g.mini_files_show_git_ignored
      MiniFiles.refresh { content = { filter = git_filter } }
      vim.notify(('Git-ignored files %s'):format(vim.g.mini_files_show_git_ignored and 'shown' or 'hidden'))
    end, { buffer = buf, desc = 'Toggle Git-ignored files' })

    -- Set the working directory to the selected folder, or its parent for a file.
    vim.keymap.set('n', 'g~', function()
      local path = current_entry()
      if not path then return end
      if vim.fn.isdirectory(path) == 0 then path = vim.fs.dirname(path) end
      vim.fn.chdir(path)
      vim.notify('Working directory: ' .. path)
    end, { buffer = buf, desc = 'Set working directory' })
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowOpen',
  desc = 'Show line numbers in mini.files',
  callback = function(args)
    local win = args.data.win_id
    vim.wo[win].number = true
    vim.wo[win].relativenumber = true
  end,
})
