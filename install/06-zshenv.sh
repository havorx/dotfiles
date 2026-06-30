#!/usr/bin/env bash
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cp "$DOTFILES/zshenv/.zshenv" "$HOME/.zshenv"
echo "  Installed ~/.zshenv"