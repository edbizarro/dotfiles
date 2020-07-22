alias ls="ls -lah --color=auto --group-directories-first"
alias ll="ls -lah --color=auto --group-directories-first"
alias l='ls -CF'

alias grep='grep --color=auto'

alias show-fonts="fc-list | cut -d ' ' -f2 | sort -u"
alias vim="nvim"
alias vi="nvim"
alias cat="bat"

alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'

alias monitor_disk='sudo iotop -Pao'

alias hdmi='xrandr --dpi 96 --output HDMI-1  --primary && mons -o'

alias sudo="sudo "

alias k-abnt2="setxkbmap -model abnt2 -layout br -variant abnt2"
alias k-us="setxkbmap -model us -layout us -variant intl"

alias desktop-mode="k-abnt2 && xrandr --dpi 96 --output DP1  --primary && mons -o && light -A 100"
alias laptop-mode="k-us && light -S 70"