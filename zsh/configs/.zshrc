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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  docker
  terraform
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=true


SPACESHIP_PROMPT_DEFAULT_SUFFIX=

SPACESHIP_GIT_SYMBOL=""
 
SPACESHIP_DOCKER_SYMBOL=" " 
SPACESHIP_DOCKER_PREFIX=""