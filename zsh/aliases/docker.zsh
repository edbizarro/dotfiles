alias dcartizan="dkc exec web php artisan"


A_BASE=$HOME/.cache/gitlab-ci-pipeline-php

# define specific cache directories
A_CONFIG=$A_BASE/.config
A_CACHE=$A_BASE/.cache
A_LOCAL=$A_BASE/.local
A_SSH=$HOME/.ssh
A_COMPOSER=$A_BASE/.composer
A_YARN=$A_BASE/.yarn

# create directories
mkdir -p $A_CONFIG
mkdir -p $A_CACHE
mkdir -p $A_LOCAL
mkdir -p $A_COMPOSER
mkdir -p $A_YARN

# reset permissions
chown -R $(whoami) $A_BASE
# home directory
A_USER_HOME=/home/php

DOCKER_OPTS="-it --rm -v $HOME:$HOME -v $(pwd):/var/www/html -v $A_COMPOSER:$A_USER_HOME/.composer -v $A_YARN:$A_USER_HOME/.yarn -v $A_CONFIG:$A_USER_HOME/.config -v $A_CACHE:$A_USER_HOME/.cache -v $A_LOCAL:$A_USER_HOME/.local -v $A_SSH:$A_USER_HOME/.ssh"

# COMPOSER
alias c="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine composer"
alias ci="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine composer install"
alias cu="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine composer up"
alias cg="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine composer global"
alias cr="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine composer require"

# YARN
alias y="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine yarn --cache-folder ~/.yarn"
alias yi="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine yarn install --pure-lock --cache-folder ~/.yarn"
alias yu="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine yarn upgrade --cache-folder ~/.yarn"

# PHP
alias p="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.3-alpine php"
#alias php="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine php"

