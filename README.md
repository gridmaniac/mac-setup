# mac-setup

Public part of my macOS setup: tiling WM, hotkeys, shell, terminal, LazyVim.

| What | Config |
|---|---|
| yabai (bsp tiling, gaps 12, ctrl+mouse move/resize) | `home/.yabairc` |
| skhd (alt+hjkl focus, hyper+hjkl swap, hyper+1..8 move to space) | `home/.skhdrc` |
| Hammerspoon — switches layout to ABC when Ghostty is focused | `home/.hammerspoon/init.lua` |
| Ghostty (JetBrains Mono 14, Mirage) | `home/.config/ghostty` |
| zsh: oh-my-zsh (wezm) + zoxide + autosuggestions | `home/.zshrc` |
| LazyVim (PHP via intelephense, Pint, Blade) | `home/.config/nvim` |
| herdr, btop, global gitignore | `home/.config/…` |
| Ctrl+1..8 → desktops, Dock, key repeat | `macos.sh` |

## Install

```sh
git clone https://github.com/gridmaniac/mac-setup.git ~/Workspace/mac-setup
cd ~/Workspace/mac-setup
./install.sh            # brew bundle + oh-my-zsh + symlinks + macOS defaults
./install.sh --no-brew --no-macos   # symlinks only
```

Existing files are moved to `~/.mac-setup-backup/<timestamp>/` before linking.
Machine-specific shell stuff goes to `~/.zshrc.local` (not tracked).

## Notes

- `hyper` in skhd is ctrl+alt+shift+cmd; a separate key for it (Karabiner, keyboard firmware) is not part of this repo.
- With SIP enabled yabai has no scripting addition, so moving windows between spaces (`hyper - 1..8`, `hyper - p/n`) may not work on recent macOS.
