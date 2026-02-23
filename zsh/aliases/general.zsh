if command -v eza &>/dev/null; then
  alias ls="eza -lah --color=auto --group-directories-first --icons"
  alias ll="eza -lah --color=auto --group-directories-first --icons"
  alias l='eza -lah --color=auto --group-directories-first --icons'
elif command -v exa &>/dev/null; then
  alias ls="exa -lah --color=auto --group-directories-first --icons"
  alias ll="exa -lah --color=auto --group-directories-first --icons"
  alias l='exa -lah --color=auto --group-directories-first --icons'
fi

alias tmux='tmux -2'

command -v rg &>/dev/null && alias grep="rg -uuu"

if command -v fd &>/dev/null; then
  alias find='fd'
elif command -v fdfind &>/dev/null; then
  alias find='fdfind'
fi

command -v tldr &>/dev/null && alias man='tldr'

alias show-fonts="fc-list | cut -d ' ' -f2 | sort -u"
alias vim="nvim"
alias vi="nvim"
# alias cat="bat"

alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'

alias monitor-disk='sudo iotop -Pao'
alias disk-details="ncdu / --exclude ~/.avfs --exclude /media --exclude /run/timeshift --exclude /timeshift --exclude /proc"

alias sudo="sudo "

alias k-abnt2="setxkbmap -model abnt2 -layout br -variant abnt2"
alias k-us="setxkbmap -model us -layout us -variant intl"

alias desktop-mode="k-us && xrandr --output DP-1 --primary --mode 3440x1440 --rate 100 && mons -o && light -A 100"
alias laptop-mode="k-us && xrandr --output eDP-1 --primary && light -S 70"

alias uvsh='source .venv/bin/activate'

gpgd(){
    gpg --output $2 --decrypt $1
}

wal-tile() {
    wal  -n -i "$@" --iterative -a 100
    feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"
}
