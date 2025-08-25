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

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(atuin init zsh)"

[ -f ~/.make_life_easier.zsh ] && source ~/.make_life_easier.zsh

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'


export PYENV_ROOT="$HOME/.pyenv"
export WORKON_HOME=$HOME/.virtualenvs

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init - zsh)"

eval "$(pyenv virtualenv-init -)"
# Added by dbt installer
export PATH="$PATH:/home/edbizarro/.local/bin"

# dbt aliases
alias dbtf=/home/edbizarro/.local/bin/dbt
