#!/usr/bin/env bash

# Loosely referenced: https://dev.to/boonecabal/how-to-create-a-lightweight-dotfiles-repository-28dh

# Get vars.
CWD="$(pwd)"
TIME="$(date +%Y%m%d%H%M%S)"
CONFIG=${XDG_CONFIG_HOME:-"$HOME/.config"}

# Create backup dir.
mkdir -p ".backup"

# Wezterm
if [ -d "$CONFIG/wezterm" ]; then
  cp -r "$CONFIG/wezterm" "$CWD/.backup/wezterm.bak.$TIME"
  rm -rf "$CONFIG/wezterm"
fi
ln -s "$CWD/wezterm" "$CONFIG/wezterm"

# NeoVim
if [ -d "$CONFIG/nvim" ]; then
  cp -r "$CONFIG/nvim" "$CWD/.backup/nvim.bak.$TIME"
  rm -rf "$CONFIG/nvim"
fi
ln -s "$CWD/neovim" "$CONFIG/nvim"

# Fish
if [ -f "$CONFIG/fish/config.fish" ]; then
  cp "$CONFIG/fish/config.fish" "$CWD/.backup/config.fish.bak.$TIME"
  rm "$CONFIG/fish/config.fish"
else
  mkdir -p "$CONFIG/fish"
fi
ln -s "$CWD/fish/config.fish" "$CONFIG/fish/config.fish"
chsh -s $(which fish)

# Lazygit
if [[ "$OSTYPE" == "darwin"* ]]; then
  LAZYGIT="$HOME/Library/Application Support/lazygit"
else
  LAZYGIT="$CONFIG/lazygit"
fi
if [ -f "$LAZYGIT/config.yml" ]; then
  cp "$LAZYGIT/config.yml" "$CWD/.backup/lg_config.yml.bak.$TIME"
  rm "$LAZYGIT/config.yml"
fi
ln -s "$CWD/lazygit/config.yml" "$LAZYGIT/config.yml"

# Btop
if [ -f "$CONFIG/btop/btop.conf" ]; then
  cp "$CONFIG/btop/btop.conf" "$CWD/.backup/btop.conf.bak.$TIME"
  rm "$CONFIG/btop/btop.conf"
else
  mkdir -p "$CONFIG/btop"
fi
ln -s "$CWD/btop/btop.conf" "$CONFIG/btop/btop.conf"
