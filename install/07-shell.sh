#!/usr/bin/env bash
set -uo pipefail

if [ "$(basename "$SHELL")" != "zsh" ]; then
  echo "  Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi