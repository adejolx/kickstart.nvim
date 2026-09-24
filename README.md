# adejolx/kickstart.nvim

A small, readable Neovim configuration based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It is a practical starting point for writing code and for learning how to build your own Neovim setup.

This is a personal fork maintained by `adejolx`. It can diverge from upstream Kickstart.nvim, so plugins, keymaps, defaults, and documentation may differ from the upstream project.

This configuration uses Neovim's built-in `vim.pack` to install plugins. It is a configuration you can adapt, not a complete Neovim distribution.

## Quick start

Follow these three steps for a normal installation. You need Neovim 0.12 or newer and Git. Search, file discovery, Tree-sitter parsers, native plugin builds, and clipboard support also use the tools listed in [`INSTALL.md`](INSTALL.md).

### 1. Clone the configuration

```sh
git clone https://github.com/adejolx/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

```powershell
git clone https://github.com/adejolx/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

If you already have a Neovim configuration, back it up first or use a separate `NVIM_APPNAME`. See [`INSTALL.md`](INSTALL.md) for platform-specific details.

### 2. Start Neovim

```sh
nvim
```

On the first launch, `vim.pack` downloads and installs the plugins declared in [`init.lua`](init.lua).

### 3. Check the setup

Run `:checkhealth` if anything does not start correctly. Use `:Mason` to inspect language servers and tools.

## Everyday workflow

Open a project with `nvim .`. The leader key is `<Space>`.

### Find and move

| Keys | Action |
| --- | --- |
| `<Space>sf` | Find files |
| `<Space>sg` | Search project text |
| `<Space>sh` | Search Neovim help |
| `<Space><Space>` | Switch between open buffers |
| `<Space>sk` | Search configured keymaps |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Move between split windows |
| `<Space>j` | Jump to a labeled location on screen |

`mini.jump2d` shows labels over likely jump locations. Press `<Space>j`, then type the label or labels shown at the destination. It works in Normal, Visual, and Operator-pending modes.

The open-buffer picker on `<Space><Space>` lists buffers by most recently used, so the buffers you opened or visited most recently appear first.

### Complete code with the LSP popup

When the completion popup is open, use `<C-n>` or `<Down>` to select the next suggestion and `<C-p>` or `<Up>` to select the previous one. Press `<C-y>` to accept the selected suggestion, `<C-e>` to close the popup, and `<C-Space>` to open it manually.

### Edit and inspect

| Keys | Action |
| --- | --- |
| `<Space>f` | Format the current buffer |
| `<Space>q` | Open the diagnostics list |
| `<Esc><Esc>` | Leave terminal mode |

### Work with language servers

When a language server is attached, these mappings are available:

| Keys | Action |
| --- | --- |
| `grd` | Go to definition |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grn` | Rename the symbol under the cursor |
| `gra` | Apply a code action |
| `<Space>th` | Toggle inlay hints |

The default setup installs and enables `lua_ls` and `stylua`. To support another language, add its language server to the `servers` table in [`init.lua`](init.lua), then restart Neovim.

## Customize the setup

Optional examples live in [`lua/kickstart/plugins`](lua/kickstart/plugins). The `mini.files` explorer is enabled by default:

```lua
require 'kickstart.plugins.mini-files'
```

Press `<Space>e` in Normal mode to reveal the current file, or `<Space>E`/`\` to toggle the explorer without revealing a file. Inside the explorer, `l` or `<CR>` opens a file and closes the explorer; `L` opens it while keeping the explorer open. `gX` opens the selected file or folder in the OS file explorer, `gy` copies its absolute path, `gY` copies its path relative to the current working directory, `gI` toggles Git-ignored entries, and `g~` changes Neovim’s working directory to the selected folder (or the parent of a selected file). Git-ignored entries are hidden by default, then dimmed when shown. Telescope’s file finder follows the same setting, and `q` closes a Telescope finder in Normal mode. Renames and moves notify supported LSP servers so they can update imports.

Other available examples are `autopairs`, `debug`, `indent_line`, and `lint`. Each module contains its own setup and keymaps. For example, enabling `debug` adds `<F5>` to continue, `<F1>` to step into, `<F2>` to step over, `<F3>` to step out, and `<Space>b` to toggle a breakpoint.

For personal plugins, create Lua modules under [`lua/custom/plugins`](lua/custom/plugins), then uncomment `require 'custom.plugins'` near the end of `init.lua`. The loader will load the Lua files in that directory.

Start with `:Tutor` and `:help`. The comments throughout [`init.lua`](init.lua) link each setting to the relevant help topic. Use `:lua vim.pack.update()` to update plugins.

See [`INSTALL.md`](INSTALL.md) for dependency installation, alternate configuration paths, first-launch commands, plugin updates, and troubleshooting.

The project is licensed under the terms in [`LICENSE.md`](LICENSE.md).
