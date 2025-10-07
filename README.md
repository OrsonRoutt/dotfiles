# OrsonRoutt's Dotfiles

## Overview

This repository contains my personal dotfiles which I use on MacOS, Linux, and Windows w/WSL. These largely include configuration for terminal utilities based around NeoVim.

My workflow is based around a single Wezterm window per project with a single NeoVim instance running, doing most of my work inside NeoVim.

I generally try to keep dependencies low so I have quite a few bespoke Lua scripts for NeoVim and Wezterm. For reference, I have implemented:
- NeoVim
    - Buffer close/clean utilities.
    - Better LSP rename (writes to qflist).
    - Machine-specific project searching/loading.
    - Overriding the fold column to stop displaying numbers.
    - A custom statusline implementation w/lazy loading & resizing.
    - Utilities for creating floating and/or persistent terminal windows.
    - My own implementation of theming w/transparency, lazy loading, switching, and persistence.
    - Interaction with Fish to set the CWD on suspend.
- Wezterm
    - Background toggling/switching w/persistence.

## Installation

To install my dotfiles, clone the repository and run `install.sh` in a terminal from the root of the repo. This will create symlinks for all the configurations in the correct places. Running this also creates backups of the files it overrode, these are placed in `.backup/` with the extension `.bak.<timestamp>`. Backup files are named arbitrarily and you should probably look in `install.sh` to work out where exactly they were before.

### Dependencies

Before running `install.sh` you should probably setup the required dependencies.

#### Environment Variables

`install.sh` uses $XDG_CONFIG_HOME to determine where it should put its config files. If you want a nonstandard config directory you will have to set $XDG_CONFIG_HOME to something else and also modify `fish/config.fish` to set its XDG environment variables as such.

Lazygit currently doesn't respect $XDG_CONFIG_HOME on MacOS so it is hardcoded to `~/Library/Application Support/lazygit/`.

#### Wezterm

I use Wezterm nightly as my terminal (nightly because I found a feature I wanted). You can find installation instructions here: https://wezterm.org/installation.html

The font I use for Wezterm is JetBrainsMono Nerd Font from: https://www.nerdfonts.com/font-downloads

#### Fish

For a shell I use Fish. Installation instructions are on its website: https://fishshell.com/

#### NeoVim

I use NeoVim as a text editor and general development tool. I am currently using a minimum of NeoVim v0.11.3. On some platforms this can be annoying to install: https://github.com/neovim/neovim/blob/master/INSTALL.md

`telescope.nvim` requires ripgrep to use 'live grep', etc.: https://github.com/BurntSushi/ripgrep/blob/master/README.md#installation

#### Lazygit

I use Lazygit for git: https://github.com/jesseduffield/lazygit/blob/master/README.md#installation

#### Btop

I use Btop as an alternative to `top`: https://github.com/aristocratos/btop

### After Installing

After installing, some things might not work because of bespoke scripts I made at 3am.

#### NeoVim

I use `coq_nvim` for completion and it has its own dependencies. Running `:COQdeps` should install these.

My NeoVim theme code needs a theme data file to load from. To generate this, launch NeoVim and run `:Theme horizon` and then press `<leader>ts`.

My NeoVim projects code needs a Lua file defining the user's projects at `$XDG_DATA_HOME/nvim/projects.lua` to not error. The format is:
- `return{["<name>"]={<directory>/,<preview file>,<initial file>,<last accessed (int)>},...}` The directory must have a trailing `/`. The entry called "neovim" is specially mapped to `:Cfg`.

For LSPs, use `:Mason` to install whatever you need. Adding a new LSP requires adding it to `lua/configs/lspconfig.lua`.

#### Wezterm

My Wezterm background code needs a file at `$XDG_DATA_HOME/wezterm` to work properly (I don't think it crashes?):
- `data.lua`: Contains a list of paths to background files with opacities `return{backgrounds={{<path1>,1.0},{<path2>,0.9},{<path3>,1.0},...}}`
