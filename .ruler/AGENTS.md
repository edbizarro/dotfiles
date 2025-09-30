# AGENTS

## Project Architecture

This is a personal Linux dotfiles repository using **GNU Stow** for symlink management. Each top-level directory represents a stow package that can be independently installed.

### Stow Package Structure

- Each directory (e.g., `git/`, `zsh/`, `tmux/`) contains config files in their target directory structure
- Running `stow <package>` from `~/.dotfiles` creates symlinks in `$HOME`
- Example: `git/.gitconfig` → `~/.gitconfig` when you run `stow git`
- Files matching `.stow-global-ignore` patterns (DS_Store, README.*, etc.) are never symlinked

### ZSH Special Case

The `zsh/` package has a unique structure:

- `zsh/configs/` contains the actual dotfiles (`.zshrc`, `.zpreztorc`, etc.)
- Install with: `cd ~/.dotfiles/zsh && stow configs -t ~/`
- `.zshrc` sources modular config from:
  - `~/.dotfiles/zsh/aliases/*.zsh` (command aliases by category)
  - `~/.dotfiles/zsh/exports/*.zsh` (environment variables)
  - `~/.dotfiles/zsh/plugins/*.zsh` (plugin configurations)

## Development Workflow

### Requirements

- i3-gaps, polybar, dunst, picom
- NerdFonts, tamzen font
- tmux + tpm, zsh + prezto
- Optional: pywal, betterlockscreen, cava, feh

### Installing Configurations

```bash
# Single package
cd ~/.dotfiles && stow <package-name>

# All packages (common pattern from README)
cd ~/.dotfiles && \
  stow i3 mopidy cava ncmpcpp stow wal git ssh tmux picom dunst xresources && \
  cd zsh && stow configs -t ~/
```

### Handling Conflicts

If stow warns about existing files, rename them first:

```bash
mv ~/.gitconfig ~/.gitconfig.old
stow git
```

### Pre-commit Hooks

Security-focused hooks run on commit/push:

- Detects private keys and AWS credentials
- Validates YAML/JSON, checks for merge conflicts
- Enforces consistent formatting (trailing whitespace, EOF, tabs)
- Run manually: `pre-commit run --all-files`

## Key Conventions

### Modular Configuration Files

- **ZSH aliases**: Split by purpose (arch.zsh, dbt.zsh, git.zsh, k8s.zsh, general.zsh)
- **ZSH exports**: Each tool/environment in its own file (pyenv.zsh, go.zsh, browser.zsh)
- **tmux configs**: Split into keybinds.tmux, settings.tmux, statusbar.tmux, plugins.tmux

### Tool Stack

- **Shell**: zsh + prezto framework
- **Terminal**: urxvt + tmux (256color, mouse enabled)
- **Editor**: neovim + vscode (aliased as `vim`/`vi`)
- **Git**: GPG signing enabled, delta for diffs, `main` as default branch
- **Display**: i3-gaps + polybar + dunst + picom
- **Theming**: pywal integration (generates colorschemes from wallpapers)
- **Python**: pyenv + pyenv-virtualenv for environment management
- **Music**: cava + mopidy

### Custom Aliases & Functions

- `ls`/`ll`/`l` → exa with icons and directory-first sorting
- `man` → tldr (simplified man pages)
- `pushme <message>` → git add, commit, push to current branch in one command
- `desktop-mode`/`laptop-mode` → xrandr + monitor + brightness presets
- `gpgd <input> <output>` → decrypt GPG files

## File Organization Patterns

### Configuration in Nested Directories

Many packages use `.config/` subdirectories to match XDG conventions:

- `nvim/.config/nvim/` → `~/.config/nvim/`
- `i3/.config/i3/` and `i3/.i3/` → both directory structures present

### SSH Hosts Management

- `ssh/hosts/` directory for organizing host-specific configs (currently only .gitkeep)
- Pattern suggests intention for modular SSH config includes

## Integration Points

- **pywal**: Colors loaded in `.zshrc` from `~/.cache/wal/`
- **atuin**: Shell history sync initialized in `.zshrc`
- **fzf**: Fuzzy finder integration sourced if available
- **kubectl**: Shell completion enabled if binary exists
- **prezto**: ZSH framework initialization happens first in `.zshrc`

## Notes for AI Agents

- When modifying ZSH configs, add new aliases/exports as separate files in appropriate subdirectories
- Stow commands should always be run from the repo root (`~/.dotfiles`)
- Git operations in this repo should use conventional commit messages (pre-commit hooks enforce quality)
- This is Arch Linux-focused (package manager commands, paths like `/usr/bin/zsh`)
- Font references (NerdFonts, tamzen, bitmap fonts) are critical for UI rendering
