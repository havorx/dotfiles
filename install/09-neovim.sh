#!/usr/bin/env bash
set -uo pipefail

NVIM_DIR="$HOME/.config/nvim"
REPO="https://github.com/havorx/astronvim_config.git"

if [ -d "$NVIM_DIR/.git" ]; then
  echo "  Neovim config repo exists — pulling latest..."
  git -C "$NVIM_DIR" pull --rebase 2>/dev/null || echo "  (pull failed, continuing with existing config)"
elif [ -d "$NVIM_DIR" ]; then
  echo "  Existing Neovim config found (not a git repo) — backing up..."
  mv "$NVIM_DIR" "${NVIM_DIR}.bak"
  echo "  Cloning Neovim config..."
  git clone "$REPO" "$NVIM_DIR" 2>/dev/null \
    && rm -rf "${NVIM_DIR}.bak" \
    || { mv "${NVIM_DIR}.bak" "$NVIM_DIR"; echo "  Clone failed — restored original config"; }
else
  echo "  Cloning Neovim config..."
  git clone "$REPO" "$NVIM_DIR" 2>/dev/null || echo "  Clone failed (no network?); skipping"
fi