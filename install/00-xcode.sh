#!/usr/bin/env bash
set -uo pipefail

if ! xcode-select -p &>/dev/null; then
  echo "  Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "  Press Enter when Xcode CLT install is complete..."
  read -r
fi