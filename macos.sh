#!/usr/bin/env bash
# macOS defaults that match the home machine. Safe to re-run.
set -euo pipefail

# Ctrl+1..8 → Switch to Desktop 1..8 (symbolic hotkeys 118–125).
# The desktops themselves must exist: create them in Mission Control first.
keycodes=(18 19 20 21 23 22 26 28)
for i in "${!keycodes[@]}"; do
  id=$((118 + i))
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>${keycodes[$i]}</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
done

# yabai needs spaces in a fixed order
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64

# Key repeat instead of the accent popup (vim motions)
defaults write -g ApplePressAndHoldEnabled -bool false

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
killall Dock

echo "macOS defaults applied. Hotkeys may need a logout to take effect."
