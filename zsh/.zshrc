if [ ! -d "$HOME/.oh-my-zsh" ]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ham"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git laravel5 command-not-found common-aliases composer docker git-extras git-flow gitignore gulp node npm pip ssh-agent supervisor tmux vagrant vim-interaction battery last-working-dir themes)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/PhpStorm-144.3656/bin:$PATH"

if [ `uname -o` = "Cygwin" ]; then  
  export VAGRANT_DETECTED_OS=cygwin
  VAGRANT_HOME=/cygdrive/c/Users/edbiz/
  export VAGRANT_HOME
fi

source $ZSH/oh-my-zsh.sh

export LANG=pt_BR.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# Ensure 'escape dot' sequence works like default bash/zsh.
bindkey '\e.' insert-last-word

# Turn off annoying autocorrect
unsetopt CORRECT_ALL

# Make history files large and shared over multiple sessions
#EXTENDED_HISTORY=ON
#export HISTFILE= ~/.zsh_history
#export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
#export HISTSIZE=100000                   # big big history
#export HISTFILESIZE=100000               # big big history
#setopt HISTAPPEND HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS SHARE_HISTORY INC_APPEND_HISTORY EXTENDED_HISTORY

# Colors for ls output
export CLICOLOR=1

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Colors for grep output
alias grep='grep --color=auto'
alias egrep='grep --color=auto'

# Ignore duplicate commands when adding to the history and some repeatedly used short commands
export HISTIGNORE="&:ls:ls *:[bf]g:exit"

export TERM=xterm-256color

# Base16 Shell
BASE16_SHELL="$HOME/.base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Set the url that Rancher is on
export RANCHER_URL=http://45.32.225.221:8080/
# Set the access key, i.e. username
export RANCHER_ACCESS_KEY=05DCAA06FEFCD6241397
# Set the secret key, i.e. password
export RANCHER_SECRET_KEY=pyqkbPPhFLaPUZa4CFWJ94K21Cv1jMusnQbDxnRx


# ALIAS

alias ls='ls -Glah --color=always'
alias ll='ls -lah'
alias l='ls -CF'

# GIT

alias gt='git status'
alias ga='git add --all'
alias gc='git commit'
alias gfs='git flow feature start'
alias gff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'

# VAGRANT

alias vu='vagrant up'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vs='vagrant status'
alias vsh='vagrant ssh'
alias vp='vagrant provision'
alias vbu='vagrant box update'

# COMPOSER

alias cu='composer update --prefer-dist'
alias ci='composer install --prefer-dist'

# NPM 
alias ni='npm install'
alias nig='npm install -g'

# GULP

alias g='gulp'
alias gw='gulp watch'
