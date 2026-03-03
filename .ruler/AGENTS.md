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

## Conventions (Will Cause Mistakes If Ignored)

- **New ZSH aliases** → create a new file in `zsh/aliases/` (never append to existing files unless the alias belongs to that category)
- **New ZSH exports** → create a new file in `zsh/exports/`
- **Optional tool aliases** → always guard with `command -v` to avoid errors on machines where the tool is missing
- **Stow commands** → always run from repo root (`~/.dotfiles`) with `--target=$HOME`, or use the Makefile
- **Pre-commit hooks** are active — they enforce formatting, detect secrets (gitleaks), and validate YAML/JSON. Run `pre-commit run --all-files` to check before committing
- **Git commits** → conventional commit messages; GPG signing is required
- **NerdFonts + Cascadia Code** are required for polybar/kitty/i3 rendering — don't change font references without checking availability

## Setup Commands

```bash
make help          # Show all targets (includes distro detection)
make all           # Full fresh-machine setup
make stow          # Symlink all packages
make stow-core     # Core only: git, ssh, zsh, tmux, nvim, vim, atuin, stow, xresources
make stow-desktop  # Desktop: i3, picom, dunst, wal, kitty
make stow-media    # Media: mopidy, mpd, ncmpcpp, pipewire
make unstow        # Remove all symlinks
```

## Key Integrations

- **pywal** → colors loaded in `.zshrc` from `~/.cache/wal/` (guarded)
- **atuin** → shell history sync (guarded)
- **prezto** → ZSH framework, loads first in `.zshrc`; modules include pacman + dpkg (both internally guarded)
- **tmux** → config split into keybinds/settings/statusbar/plugins `.tmux` files
