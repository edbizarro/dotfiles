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

# Composer
alias c="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer"
alias ci="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer install"
alias cu="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer up"
alias cg="docker run -it -v ~/:/var/www/html edbizarro/gitlab-ci-pipeline-php:7.1-alpine composer global"

# Yarn
alias y="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine yarn"
alias yi="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine yarn install --pure-lock"
alias yu="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine yarn upgrade"

alias p="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine php"
alias php="docker run -it -v $(pwd -P):/var/www/html -v ~/.ssh:/home/php/.ssh edbizarro/gitlab-ci-pipeline-php:7.1-alpine php"
