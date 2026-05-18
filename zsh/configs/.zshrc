# -*- mode: sh; sh-shell: zsh -*-
# Dedup arrays so prepends/appends never accumulate duplicates.
typeset -gU path fpath cdpath mailpath

# --- jus-cli completions must be in fpath before prezto runs compinit ---
[[ -d "$HOME/.config/jus-cli/completion_zsh" ]] && fpath=("$HOME/.config/jus-cli/completion_zsh" $fpath)

# --- Prezto (provides prompt, completion/compinit, syntax highlight, etc.) ---
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# --- Dotfiles modules: exports → aliases → plugins ---
# null_glob: empty dir doesn't produce literal `*` matches.
setopt local_options null_glob
for file in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/exports/*.zsh; do
    source "$file"
done
for file in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/aliases/*.zsh; do
    source "$file"
done
for file in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/*.zsh; do
    source "$file"
done

# --- pywal terminal palette ---
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
[[ -f ~/.cache/wal/colors-tty.sh ]] && source ~/.cache/wal/colors-tty.sh

# --- Interactive tool integrations (atuin needs its bin on PATH first) ---
[[ -f "$HOME/.atuin/bin/env" ]] && source "$HOME/.atuin/bin/env"
command -v atuin &>/dev/null && eval "$(atuin init zsh)"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.make_life_easier.zsh ]] && source ~/.make_life_easier.zsh

# --- Deno (its env file dedupes PATH internally; harmless if re-sourced) ---
[[ -f "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

# --- bun runtime + completions ---
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && path=("$BUN_INSTALL/bin" $path)
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# --- jus-cli (init_zsh.sh exports work tokens — replace with secret manager later) ---
[[ -f "$HOME/.config/jus-cli/init_zsh.sh" ]] && source "$HOME/.config/jus-cli/init_zsh.sh"

# --- PAI configuration (added by Kai Bundle installer) ---
export DA="HAL"
export TIME_ZONE="America/Sao_Paulo"
export PAI_SOURCE_APP="$DA"
export ZSH_WAKATIME_PROJECT_DETECTION=true
alias pai='bun "$HOME/.claude/PAI/TOOLS/pai.ts"'
alias hal="pai"


[[ -f "$HOME/.config/jus-cli/init_zsh.sh" ]] && . "$HOME/.config/jus-cli/init_zsh.sh"

[[ -d "$HOME/.config/jus-cli/completion_zsh" ]] && fpath=("$HOME/.config/jus-cli/completion_zsh" $fpath)
autoload -U compinit; compinit


[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# PAI alias
alias pai='bun /home/eduardo.bizarro/.claude/PAI/TOOLS/pai.ts'
