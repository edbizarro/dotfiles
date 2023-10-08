# GIT
alias gt='git status'
alias ga='git add --all'
alias gc='git commit -S'
alias gfs='git flow feature start'
alias gff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'

# Commit the current changes and push to the current branch
function pushme {
  br=`git branch | grep "*"`
  git add --all
  if (($# > 1)); then
    params=''
    for i in $*;
    do
      params=" $params $i"
    done
    git commit -S -m "$params"
  else
    git commit -S -m "$1"
  fi
  git push origin ${br/* /}
}
