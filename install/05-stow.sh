#!/usr/bin/env bash
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Create XDG dirs
mkdir -p ~/.config/zsh ~/.config/wezterm ~/.config/git ~/.config/tmux \
  ~/.config/lazygit ~/.config/lf ~/.config/mise \
  ~/.config/yabai ~/.config/skhd

# Back up existing files that would conflict
for f in ~/.config/zsh/.zshrc ~/.config/wezterm/wezterm.lua ~/.config/git/config \
         ~/.config/tmux/tmux.conf ~/.config/lazygit/config.yml ~/.config/lf/lfrc \
         ~/.config/mise/config.toml; do
  if [ -e "$f" ] && [ ! -L "$f" ]; then
    mv "$f" "${f}.bak"
    echo "  Backed up existing file: $f -> ${f}.bak"
  fi
done

# Stow packages
cd "$DOTFILES"
PACKAGES="zsh wezterm git tmux lazygit lf mise"

if [ "$(uname -s)" = "Darwin" ]; then
  PACKAGES="$PACKAGES yabai skhd"
fi

stow -v -t "$HOME" $PACKAGES

# WezTerm sync to Windows
WINDOWS_USER=$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r\n ' || true)
if [ -n "$WINDOWS_USER" ]; then
  REPO_FILE="$DOTFILES/wezterm/.config/wezterm/wezterm.lua"
  WIN_FILE="/mnt/c/Users/${WINDOWS_USER}/.wezterm.lua"
  cp "$REPO_FILE" "$WIN_FILE"
  echo "  Synced WezTerm config to Windows"
fi