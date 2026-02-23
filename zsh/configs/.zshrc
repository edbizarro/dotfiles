# Source Prezto.
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

export ZSH_WAKATIME_PROJECT_DETECTION=true

[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
[[ -f ~/.cache/wal/colors-tty.sh ]] && source ~/.cache/wal/colors-tty.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.make_life_easier.zsh ] && source ~/.make_life_easier.zsh

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'


command -v atuin &>/dev/null && eval "$(atuin init zsh)"


# PAI Configuration (added by Kai Bundle installer)
export DA=""HAL""
export TIME_ZONE="America/Sao_Paulo"
export PAI_SOURCE_APP="$DA"

# PAI alias
alias pai='bun ~/.claude/skills/PAI/Tools/pai.ts'

# export ATUIN_TMUX_POPUP=false
