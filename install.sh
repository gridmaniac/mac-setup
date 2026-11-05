#!/usr/bin/env bash
# Usage: ./install.sh [--no-brew] [--no-macos]
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.mac-setup-backup/$(date +%Y%m%d-%H%M%S)"
WITH_BREW=1
WITH_MACOS=1
for arg in "$@"; do
  case "$arg" in
    --no-brew) WITH_BREW=0 ;;
    --no-macos) WITH_MACOS=0 ;;
  esac
done

link() {
  local src="$REPO/home/$1" dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP/$(dirname "$1")"
    mv "$dst" "$BACKUP/$1"
    echo "backup: ~/$1 → $BACKUP/$1"
  fi
  ln -s "$src" "$dst"
  echo "link:   ~/$1"
}

if [ "$WITH_BREW" = 1 ]; then
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew bundle --file="$REPO/Brewfile"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

for f in \
  .zshrc \
  .yabairc \
  .skhdrc \
  .hammerspoon \
  .config/ghostty \
  .config/nvim \
  .config/git/ignore \
  .config/herdr/config.toml \
  .config/btop/btop.conf
do
  link "$f"
done

if command -v yabai >/dev/null; then yabai --start-service || true; fi
if command -v skhd >/dev/null; then skhd --start-service || true; fi
open -a Hammerspoon || true

if [ "$WITH_MACOS" = 1 ]; then
  "$REPO/macos.sh"
fi

cat <<'EOF'

Done. Manual steps:
  1. System Settings → Privacy & Security → Accessibility: allow yabai, skhd, Hammerspoon.
  2. Mission Control: create desktops 1–8 so Ctrl+1..8 has somewhere to go.
  3. Keyboard → Input Sources: add Russian (ABC is the one Hammerspoon switches to in Ghostty).
  4. Open nvim once — LazyVim installs plugins itself.
EOF
