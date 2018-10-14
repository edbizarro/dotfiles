alias dkc=docker-compose


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

docker-kill-all() {
    docker kill $(docker ps -a -q);
}

docker-stop-all() {
    docker stop $(docker ps -a -q);
}

docker-rm-all() {
    docker rm $(docker ps -a -q);
}

docker-rmi-all() {
    docker rmi $(docker images -a -q);
}

DOCKER_OPTS="-it --rm -v $HOME:$HOME -v $(pwd):/var/www/html -v $A_COMPOSER:$A_USER_HOME/.composer -v $A_YARN:$A_USER_HOME/.yarn -v $A_CONFIG:$A_USER_HOME/.config -v $A_CACHE:$A_USER_HOME/.cache -v $A_LOCAL:$A_USER_HOME/.local -v $A_SSH:$A_USER_HOME/.ssh"

# COMPOSER
alias c="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine composer"
alias ci="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine composer install"
alias ci5="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:5.6 composer install"
alias cu5="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:5.6 composer up"
alias cu="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine composer up"
alias cg="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine composer global"
alias cr="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine composer require"

# YARN
alias y="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine yarn --cache-folder ~/.yarn"
alias yi="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine yarn install --pure-lock --cache-folder ~/.yarn"
alias yu="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine yarn upgrade --cache-folder ~/.yarn"

# PHP
alias p="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine php"
#alias php="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.2-alpine php"

