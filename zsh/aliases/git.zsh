# GIT
alias gt='git status'
alias ga='git add --all'
alias gc='git commit'
alias gfs='git flow feature start'
alias gff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'

# pushme: push da branch atual.
#   sem args: git push (rápido, quando você já commitou).
#   com args: git add --all && git commit -m "$*" && git push.
function pushme {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || {
    echo "pushme: not on a branch (detached HEAD?)" >&2
    return 1
  }
  if [[ $# -gt 0 ]]; then
    git add --all || return $?
    git commit -m "$*" || return $?
  fi
  git push origin "$branch"
}
