A_BASE=$HOME/.cache/gitlab-ci-pipeline-php

# define specific cache directories
A_CONFIG=$A_BASE/.config
A_CACHE=$A_BASE/.cache
A_LOCAL=$A_BASE/.local
A_SSH=$HOME/.ssh
A_COMPOSER=$A_BASE/.composer

# create directories
mkdir -p $A_CONFIG
mkdir -p $A_CACHE
mkdir -p $A_LOCAL
mkdir -p $A_COMPOSER

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

DOCKER_OPTS="-it --rm -v $(pwd):/var/www/html -v $A_COMPOSER:$A_USER_HOME/.composer -v $A_CONFIG:$A_USER_HOME/.config -v $A_CACHE:$A_USER_HOME/.cache -v $A_LOCAL:$A_USER_HOME/.local -v $A_SSH:$A_USER_HOME/.ssh"
# Composer
alias c="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer"
alias ci="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer install"
alias cu="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer up"
alias cg="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer global"
alias cr="docker run $DOCKER_OPTS edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer require"

# Yarn
alias y="docker run -it --rm -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1 yarn"
alias yi="docker run -it --rm -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1 yarn install --pure-lock"
alias yu="docker run -it --rm -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1 yarn upgrade"

alias p="docker run -it --rm -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine php"
alias php="docker run -it --rm -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine php"
