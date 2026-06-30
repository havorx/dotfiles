#!/usr/bin/env bash
set -uo pipefail

if [ ! -x "$HOME/.local/bin/mise" ]; then
  echo "  Installing mise..."
  curl https://mise.run | sh
else
  echo "  mise already installed"
fi