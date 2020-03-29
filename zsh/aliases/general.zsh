alias ls="ls -lah --color=auto --group-directories-first"
alias ll="ls -lah --color=auto --group-directories-first"
alias l='ls -CF'

alias show-fonts="fc-list | cut -d ' ' -f2 | sort -u"
alias vim="nvim"
alias vi="nvim"

alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'

alias monitor_disk='sudo iotop -Pao'

alias hdmi='xrandr --dpi 96 --output HDMI-1  --primary && mons -o'

alias sudo="sudo "

alias abnt2="setxkbmap -model abnt2 -layout br -variant abnt2"