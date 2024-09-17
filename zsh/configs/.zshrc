# Prezto Initialization
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

for file in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/aliases/*.zsh; do
    source $file
done

for file in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/exports/*.zsh; do
    source $file
done

for file in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/*.zsh; do
    source $file
done

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.garden/bin:$PATH"
export ZSH_WAKATIME_PROJECT_DETECTION=true

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
source ~/.make_life_easier.zsh

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

eval "$(atuin init zsh)"
