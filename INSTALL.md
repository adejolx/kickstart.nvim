# Installation details

This guide covers the dependencies and setup choices that are not needed for the first quick start. For the normal installation flow, start with [`README.md`](README.md).

This repository is a personal fork maintained by `adejolx`, based on [upstream Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It may use different plugins, mappings, and defaults, so follow this repository's files when they differ from upstream documentation.

## Dependencies

Install the following before starting Neovim:

- [Neovim](https://neovim.io/) 0.12 or newer
- `git`, `make`, `unzip`, and a C compiler
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) for project search
- [`fd`](https://github.com/sharkdp/fd) for file discovery
- [Tree-sitter CLI](https://tree-sitter.github.io/tree-sitter/cli/)
- A clipboard provider such as `xclip`, `xsel`, or `win32yank`

Language-specific features need their own tools. Install the runtime or compiler for the languages you use, such as `go` for Go or `npm` for TypeScript. Mason can install many language servers and formatters after Neovim starts.

A [Nerd Font](https://www.nerdfonts.com/) is optional. If you install and select one in your terminal, set `vim.g.have_nerd_font = true` in `init.lua` to enable its icons.

## Configuration paths

Neovim searches these locations for its configuration:

| Platform | Path |
| --- | --- |
| Linux / macOS | `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim` |
| Windows | `%LOCALAPPDATA%\nvim` |

If the target directory already contains a configuration, back it up first. You can also keep this configuration separate with `NVIM_APPNAME`:

```sh
git clone https://github.com/adejolx/kickstart.nvim.git ~/.config/nvim-adejolx
NVIM_APPNAME=nvim-adejolx nvim
```

On Windows PowerShell, use an equivalent directory under `$env:LOCALAPPDATA` and set `NVIM_APPNAME` for the session before running `nvim`.

## Installing dependencies

Use your operating system's package manager where possible. The exact package names vary by distribution.

For Ubuntu or Debian-based systems, the common dependencies are:

```sh
sudo apt update
sudo apt install git make gcc ripgrep fd-find tree-sitter-cli unzip xclip neovim
```

For Fedora:

```sh
sudo dnf install git make gcc ripgrep fd-find tree-sitter-cli unzip neovim
```

For Arch Linux:

```sh
sudo pacman -S --needed git make gcc ripgrep fd tree-sitter-cli unzip neovim
```

On macOS, [Homebrew](https://brew.sh/) provides the usual packages:

```sh
brew install neovim git make ripgrep fd tree-sitter
```

On Windows, install Neovim and Git with [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/), then install the remaining command-line tools through your preferred package manager. `make` and a C compiler are needed to build optional native plugins such as Telescope's FZF extension.

## First launch and plugin updates

The first launch downloads the plugins declared in `init.lua` through Neovim's built-in `vim.pack`. If a plugin needs a build step, the configuration runs it automatically when possible.

Useful commands:

```vim
:checkhealth
:Mason
:lua vim.pack.update(nil, { offline = true })
:lua vim.pack.update()
```

The first command reports missing dependencies. `:Mason` shows language servers and tools. The offline `vim.pack` command previews plugin state; the second fetches updates.

## Troubleshooting

If plugins do not install, check that `git` is available and run `:checkhealth`. If Telescope's native FZF extension is missing, install `make` and restart Neovim. If search mappings return no results, confirm that `rg` and `fd` are on your `PATH`.

If Tree-sitter reports an error such as `ENOENT: no such file or directory (cmd): 'tree-sitter'` while installing a parser, the Tree-sitter CLI is missing or is not on your `PATH`. Install the `tree-sitter-cli` package using the instructions above, or install it with npm:

```sh
npm install --global tree-sitter-cli
```

Verify that Neovim can find it, then restart Neovim and retry the parser installation:

```sh
tree-sitter --version
```

```vim
:lua require('nvim-treesitter').install('typescript')
```

For language server problems, open `:Mason`, confirm that the server is installed, and check `:LspInfo` in a buffer of the expected filetype. The configured servers are `lua_ls` and `stylua`; other languages must be added to the `servers` table in `init.lua`.
