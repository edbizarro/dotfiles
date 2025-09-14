# Dotfiles Configuration

## Project Overview

Personal dotfiles collection for Linux desktop environment using i3wm,
configured for development workflow with vim/neovim, tmux, and zsh.

## Key Components

- **i3wm**: Window manager with gaps, polybar, dunst notifications
- **Terminal**: alacritty + tmux + zsh (prezto framework)
- **Editor**: nvim configuration
- **Audio**: mopidy, mpd, ncmpcpp, cava, pipewire
- **Tools**: git, ssh, wal (pywal), picom compositor

## Installation

Uses GNU Stow for symlink management:

```bash
cd ~/.dotfiles
stow <config-name>  # e.g., stow git
```

## Development Commands

```bash
# Pre-commit hooks (security & formatting)
pre-commit run --all-files

# Install all configs at once
stow i3 mopidy cava ncmpcpp git ssh tmux picom dunst xresources && \
  cd zsh && stow configs -t ~/
```

## Requirements

- i3-gaps, polybar, dunst, picom
- NerdFonts, tamzen font
- tmux + tpm, zsh + prezto
- Optional: pywal, betterlockscreen, cava, feh

## Notes

- Backup existing configs before stowing (rename .gitconfig to .gitconfig.old)
- Security: Pre-commit hooks detect private keys and AWS credentials
- Uses Arch Linux package names in documentation
