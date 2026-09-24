# adejolx/kickstart.nvim

A small, readable Neovim configuration based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It is a practical starting point for writing code and for learning how to build your own Neovim setup.

This is a personal fork maintained by `adejolx`. It can diverge from upstream Kickstart.nvim, so plugins, keymaps, defaults, and documentation may differ from the upstream project.

This configuration uses Neovim's built-in `vim.pack` to install plugins. It is a configuration you can adapt, not a complete Neovim distribution.

## Quick start

You need Neovim 0.12 or newer, Git, and the external tools listed in [`INSTALL.md`](INSTALL.md). If Neovim is already installed, clone the configuration into its config directory:

```sh
# Linux and macOS
git clone https://github.com/adejolx/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

```powershell
# Windows PowerShell
git clone https://github.com/adejolx/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

Start Neovim and let it install the plugins:

```sh
nvim
```

If you need platform-specific dependencies, an alternate config location, or troubleshooting help, see [`INSTALL.md`](INSTALL.md).

## Start writing code

Open a project with `nvim .`, then use these mappings in Normal mode. The leader key is `<Space>`.

| Keys | Action |
| --- | --- |
| `<Space>sf` | Find files |
| `<Space>sg` | Search project text |
| `<Space>sh` | Search Neovim help |
| `<Space><Space>` | Switch between open buffers |
| `<Space>f` | Format the current buffer |
| `<Space>q` | Open the diagnostics list |
| `<Space>sk` | Search all configured keymaps |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Move between split windows |
| `<Esc><Esc>` | Leave terminal mode |

When a language server is attached, these mappings are available:

| Keys | Action |
| --- | --- |
| `grd` | Go to definition |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grn` | Rename the symbol under the cursor |
| `gra` | Apply a code action |
| `<Space>th` | Toggle inlay hints |

The default setup installs and enables `lua_ls` and `stylua`. Open `:Mason` to inspect the installed tools or add tools for another language. Add the language server to the `servers` table in [`init.lua`](init.lua), then restart Neovim.

## Optional plugins

Optional examples are stored in [`lua/kickstart/plugins`](lua/kickstart/plugins) and are disabled until you enable them. To add a file explorer, uncomment this line near the end of [`init.lua`](init.lua):

```lua
require 'kickstart.plugins.neo-tree'
```

Restart Neovim, then press `\` in Normal mode to open Neo-tree. Press `\` again inside the explorer to close it.

Other available examples are `autopairs`, `debug`, `indent_line`, and `lint`. Each module contains its own setup and keymaps. For example, enabling `debug` adds `<F5>` to continue, `<F1>` to step into, `<F2>` to step over, `<F3>` to step out, and `<Space>b` to toggle a breakpoint.

For personal plugins, create Lua modules under [`lua/custom/plugins`](lua/custom/plugins), then uncomment `require 'custom.plugins'` near the end of `init.lua`. The loader will load the Lua files in that directory.

## Learn and customize

Start with `:Tutor`, `:help`, and `:checkhealth`. To discover the configuration's mappings, use `<Space>sk`; to search Neovim's documentation, use `<Space>sh`.

The comments throughout [`init.lua`](init.lua) link each setting to the relevant help topic. Read the section you want to change, follow its `:help` reference, and then edit the configuration. Use `:lua vim.pack.update()` to update plugins.

The project is licensed under the terms in [`LICENSE.md`](LICENSE.md).
