

<!-- Source: .ruler/AGENTS.md -->

# AGENTS

## What This Is

Personal Linux dotfiles repo. **GNU Stow** manages symlinks — each top-level directory is a stow package. Supports **Arch Linux** and **Ubuntu 24.04**.

## Critical: Non-Obvious Patterns

### ZSH Has a Special Stow Structure

ZSH does NOT stow from repo root like other packages:

```bash
cd ~/.dotfiles/zsh && stow configs -t ~/    # NOT: stow --target=$HOME zsh
```

The Makefile handles this automatically — always prefer `make stow` or `make stow-core`.

### Multi-Distro Conditional Logic

`$DISTRO_ID` (set by `zsh/exports/00-distro.zsh`) is `"arch"` or `"ubuntu"`. Use it for any distro-specific logic. The Makefile mirrors this detection.

### Polybar Hardware Config

`hardware.ini` is **gitignored** and machine-specific. After stowing, run `make polybar-hw` to generate it.

### Rofi Uses Pywal Colors

`rofi/.config/rofi/config.rasi` imports `~/.cache/wal/colors-rofi-dark` for theming. Like pywal in `.zshrc`, this depends on `wal` having been run at least once.

## Stow Package Groups

Current groups defined in the Makefile:

- **Core**: git, ssh, zsh, tmux, nvim, vim, atuin, stow, xresources
- **Desktop**: i3, picom, dunst, wal, kitty
- **Media**: mopidy, mpd, ncmpcpp, pipewire
- **Backup**: borgmatic
- **Standalone** (not in a group): rofi, scripts, wallpapers, cava, borgmatic

Note: `rofi`, `scripts`, and `wallpapers` exist as stow packages but are **not yet in any Makefile group** — they must be stowed manually or added to a group.

## Conventions (Will Cause Mistakes If Ignored)

- **New ZSH aliases** → create a new file in `zsh/aliases/` (never append to existing files unless the alias belongs to that category)
- **New ZSH exports** → create a new file in `zsh/exports/`
- **Optional tool aliases** → always guard with `command -v` to avoid errors on machines where the tool is missing
- **Stow commands** → always run from repo root (`~/.dotfiles`) with `--target=$HOME`, or use the Makefile
- **Pre-commit hooks** are active — they enforce formatting, detect secrets (gitleaks), and validate YAML/JSON. Run `pre-commit run --all-files` to check before committing
- **Git commits** → conventional commit messages; GPG signing is required
- **NerdFonts + Cascadia Code + FantasqueSansM Nerd Font** are required for polybar/kitty/i3/rofi rendering — don't change font references without checking availability

## Setup Commands

```bash
make help          # Show all targets (includes distro detection)
make all           # Full fresh-machine setup
make stow          # Symlink all packages
make stow-core     # Core only: git, ssh, zsh, tmux, nvim, vim, atuin, stow, xresources
make stow-desktop  # Desktop: i3, picom, dunst, wal, kitty
make stow-media    # Media: mopidy, mpd, ncmpcpp, pipewire
make unstow        # Remove all symlinks

# Standalone packages (not in groups yet)
stow --target=$HOME rofi scripts wallpapers
```

## Key Integrations

- **pywal** → colors loaded in `.zshrc` from `~/.cache/wal/` (guarded); also imported by rofi config
- **rofi** → application launcher, bound to `$mod+d` (run) and `$mod+Shift+d` (window) in i3; themed via pywal
- **atuin** → shell history sync (guarded)
- **prezto** → ZSH framework, loads first in `.zshrc`; modules include pacman + dpkg (both internally guarded)
- **tmux** → config split into keybinds/settings/statusbar/plugins `.tmux` files
- **ufetch-arch** → minimal system info script in `scripts/.local/bin/`
