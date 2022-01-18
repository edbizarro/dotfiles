export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export WORKON_HOME=$HOME/.virtualenvs

if command -v pyenv 1>/dev/null 2>&1; then
  source $HOME/.local/bin/virtualenvwrapper.sh
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"
