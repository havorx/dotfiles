#!/usr/bin/env bash
set -uo pipefail

if [ ! -d "$HOME/.config/nvim" ]; then
  echo "  Cloning Neovim config..."
  git clone git@github.com:havorx/astronvim_config.git "$HOME/.config/nvim"
else
  echo "  Neovim config already exists — pulling latest..."
  git -C "$HOME/.config/nvim" pull --rebase 2>/dev/null || true
fi