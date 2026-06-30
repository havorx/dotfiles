#!/usr/bin/env bash
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES/lib/utils.sh"

if ! cmd_exists brew; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(brew shellenv)"
fi

echo "  Installing from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"