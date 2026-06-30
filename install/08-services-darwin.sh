#!/usr/bin/env bash
set -uo pipefail

if ! launchctl list 2>/dev/null | grep -q com.asmvik.yabai; then
  yabai --start-service
  echo "  Started yabai"
fi

if ! launchctl list 2>/dev/null | grep -q com.asmvik.skhd; then
  skhd --start-service
  echo "  Started skhd"
fi

defaults write com.apple.dock mru-spaces -bool false
killall Dock 2>/dev/null || true

echo "  Note: Grant Accessibility permissions to yabai and skhd in"
echo "  System Settings > Privacy & Security > Accessibility"