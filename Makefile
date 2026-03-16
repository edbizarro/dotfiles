# Dotfiles Makefile — automates setup for Arch Linux and Ubuntu
# Usage: make [target]
# Run 'make' or 'make help' to see all available targets.

.DEFAULT_GOAL := help
SHELL := /bin/bash

DOTFILES_DIR := $(shell pwd)

# Distro detection (mirrors zsh/exports/00-distro.zsh logic)
# Reads ID and ID_LIKE from os-release, maps derivatives to arch or ubuntu
_OS_ID      := $(shell . /etc/os-release 2>/dev/null && echo $$ID)
_OS_ID_LIKE := $(shell . /etc/os-release 2>/dev/null && echo $$ID_LIKE)

# Map known distro IDs to arch or ubuntu
ifneq ($(filter arch endeavouros manjaro garuda artix,$(_OS_ID)),)
  DISTRO_ID := arch
else ifneq ($(filter ubuntu pop linuxmint elementary zorin,$(_OS_ID)),)
  DISTRO_ID := ubuntu
else ifneq ($(findstring arch,$(_OS_ID_LIKE)),)
  DISTRO_ID := arch
else ifneq ($(findstring ubuntu,$(_OS_ID_LIKE))$(findstring debian,$(_OS_ID_LIKE)),)
  DISTRO_ID := ubuntu
else ifdef _OS_ID
  DISTRO_ID := $(_OS_ID)
else
  DISTRO_ID := unknown
endif

# ─── Stow Package Groups ─────────────────────────────────────────────
CORE_PACKAGES    := git ssh zsh tmux nvim vim atuin stow xresources
DESKTOP_PACKAGES := i3 picom dunst wal kitty
MEDIA_PACKAGES   := mopidy mpd ncmpcpp pipewire
BACKUP_PACKAGES  := borgmatic

ALL_PACKAGES := $(CORE_PACKAGES) $(DESKTOP_PACKAGES) $(MEDIA_PACKAGES) $(BACKUP_PACKAGES)

# Packages that use standard stow (everything except zsh)
STOW_PACKAGES := $(filter-out zsh,$(ALL_PACKAGES))

# ─── Arch Linux Packages ─────────────────────────────────────────────
ARCH_PACMAN := i3-wm polybar picom dunst zsh tmux stow git curl \
	eza fd ripgrep tldr fzf neovim python-pywal feh \
	mopidy ncmpcpp borgmatic kitty atuin uv \
	ttf-cascadia-code ttf-nerd-fonts-symbols

ARCH_AUR := betterlockscreen

# ─── Ubuntu Packages ─────────────────────────────────────────────────
UBUNTU_APT := i3 polybar picom dunst zsh tmux stow git curl \
	eza fd-find ripgrep tldr fzf neovim python3-pip \
	borgmatic kitty

# ─── Targets ──────────────────────────────────────────────────────────

.PHONY: help all install install-arch install-ubuntu \
	stow stow-core stow-desktop stow-media unstow \
	fonts prezto tmux-plugins vim-plug polybar-hw pre-commit atuin clean

help: ## Show all available targets
	@echo ""
	@echo "  Dotfiles Makefile — $(DISTRO_ID) detected"
	@echo "  ──────────────────────────────────────────"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  Packages: $(ALL_PACKAGES)"
	@echo ""

all: install fonts stow prezto tmux-plugins vim-plug polybar-hw pre-commit ## Full fresh-machine setup

# ─── Package Installation ─────────────────────────────────────────────

install: ## Install system packages for detected distro
ifeq ($(DISTRO_ID),arch)
	@$(MAKE) install-arch
else ifeq ($(DISTRO_ID),ubuntu)
	@$(MAKE) install-ubuntu
else
	@echo "Unsupported distro: $(DISTRO_ID)"
	@exit 1
endif

install-arch: ## Install Arch packages (pacman + yay)
	sudo pacman -S --needed --noconfirm $(ARCH_PACMAN)
	@if command -v yay >/dev/null 2>&1; then \
		yay -S --needed --noconfirm $(ARCH_AUR); \
	else \
		echo "yay not found — skipping AUR packages: $(ARCH_AUR)"; \
	fi

install-ubuntu: ## Install Ubuntu packages (apt)
	sudo apt update
	sudo apt install -y $(UBUNTU_APT)

# ─── Stow (Symlink Management) ───────────────────────────────────────

stow: stow-core stow-desktop stow-media ## Symlink all packages
	@stow --target=$(HOME) $(BACKUP_PACKAGES)
	@echo "All packages stowed."

stow-core: ## Symlink core packages (git, zsh, tmux, nvim, ...)
	@stow --target=$(HOME) $(filter-out zsh,$(CORE_PACKAGES))
	@cd $(DOTFILES_DIR)/zsh && stow configs -t $(HOME)
	@echo "Core packages stowed."

stow-desktop: ## Symlink desktop packages (i3, picom, dunst, ...)
	@stow --target=$(HOME) $(DESKTOP_PACKAGES)
	@echo "Desktop packages stowed."

stow-media: ## Symlink media packages (mopidy, mpd, ncmpcpp, ...)
	@stow --target=$(HOME) $(MEDIA_PACKAGES)
	@echo "Media packages stowed."

unstow: ## Remove all symlinks
	@stow -D --target=$(HOME) $(STOW_PACKAGES) || true
	@cd $(DOTFILES_DIR)/zsh && stow -D configs -t $(HOME) || true
	@echo "All packages unstowed."

# ─── Tool Installation ────────────────────────────────────────────────

fonts: ## Install NerdFonts + Cascadia Code
	@mkdir -p $(HOME)/.local/share/fonts
	@if ! fc-list | grep -qi "CascadiaCode.*Nerd"; then \
		echo "Installing Cascadia Code Nerd Font..."; \
		curl -fLo /tmp/CascadiaCode.zip \
			https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip; \
		unzip -o /tmp/CascadiaCode.zip -d $(HOME)/.local/share/fonts/CascadiaCode; \
		rm -f /tmp/CascadiaCode.zip; \
		fc-cache -fv; \
	else \
		echo "Cascadia Code Nerd Font already installed."; \
	fi

prezto: ## Install Prezto ZSH framework
	@if [ ! -d "$(HOME)/.zprezto" ]; then \
		echo "Cloning Prezto..."; \
		git clone --recursive https://github.com/sorin-ionescu/prezto.git $(HOME)/.zprezto; \
	else \
		echo "Prezto already installed."; \
	fi

tmux-plugins: ## Install TPM and tmux plugins
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "Cloning TPM..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	else \
		echo "TPM already installed."; \
	fi
	@echo "Run 'prefix + I' inside tmux to install plugins."

vim-plug: ## Install vim-plug for Neovim
	@if [ -f "$(HOME)/.local/share/nvim/site/autoload/plug.vim" ]; then \
		echo "vim-plug already installed."; \
	else \
		echo "Installing vim-plug for Neovim..."; \
		curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
		echo "vim-plug installed. Run :PlugInstall inside Neovim to install plugins."; \
	fi

polybar-hw: ## Detect hardware for polybar configuration
	@if [ -f "$(HOME)/.config/polybar/setup-hardware.sh" ]; then \
		bash $(HOME)/.config/polybar/setup-hardware.sh; \
	else \
		echo "setup-hardware.sh not found — stow i3/polybar first."; \
	fi

pre-commit: ## Setup pre-commit hooks
	@if command -v pre-commit >/dev/null 2>&1; then \
		cd $(DOTFILES_DIR) && pre-commit install; \
	else \
		echo "Installing pre-commit..."; \
		pip install pre-commit || pip3 install pre-commit; \
		cd $(DOTFILES_DIR) && pre-commit install; \
	fi

atuin: ## Install Atuin shell history
	@if command -v atuin >/dev/null 2>&1; then \
		echo "Atuin already installed."; \
	else \
		echo "Installing Atuin..."; \
		curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh; \
	fi

clean: unstow ## Remove all symlinks (alias for unstow)
