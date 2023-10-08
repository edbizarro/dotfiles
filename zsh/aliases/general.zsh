alias ls="ls -lah --color=auto --group-directories-first"
alias ll="ls -lah --color=auto --group-directories-first"
alias l='ls -CF'
alias tmux='tmux -2'

alias grep='grep --color=auto'
alias man='tldr'

alias show-fonts="fc-list | cut -d ' ' -f2 | sort -u"
alias vim="nvim"
alias vi="nvim"
# alias cat="bat"

alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'

alias monitor_disk='sudo iotop -Pao'
alias disk-details="ncdu / --exclude ~/.avfs --exclude /media"

alias sudo="sudo "

alias k-abnt2="setxkbmap -model abnt2 -layout br -variant abnt2"
alias k-us="setxkbmap -model us -layout us -variant intl"

alias desktop-mode="k-us && xrandr --output HDMI-1 --primary --mode 3440x1440 --rate 100 && mons -o && light -A 100"
alias laptop-mode="k-us && xrandr --output eDP-1 --primary && mons -o"
