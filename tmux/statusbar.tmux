## Status bar design
# status line
set -g status-justify left
# set -g status-bg default
# set -g status-fg colour12
set -g status-interval 2


#window mode
#setw -g mode-bg colour6
#setw -g mode-fg colour0

# window status
setw -g window-status-format " #F#I:#W#F "
setw -g window-status-current-format " #F#I:#W#F "
setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
#setw -g window-status-current-bg colour0
#setw -g window-status-current-fg colour11
#setw -g window-status-current-attr dim
#setw -g window-status-bg green
#setw -g window-status-fg black
#setw -g window-status-attr reverse

# loud or quiet?
set-option -g visual-bell off
set-option -g visual-silence off
set-option -g bell-action none

#  The modes {
setw -g clock-mode-colour colour135
#setw -g mode-attr bold
#setw -g mode-fg colour196
#setw -g mode-bg colour238


# }
# The statusbar {

set -g status-position bottom
# set -g status-bg colour18
# set -g status-fg colour137
#set -g status-attr dim
set -g status-left ''
set -g status-right ''
set -g window-status-separator ''

#setw -g window-status-current-fg colour1
#setw -g window-status-current-bg colour19
#setw -g window-status-current-attr bold
setw -g window-status-current-format ' #W #[fg=colour249]#F '

#setw -g window-status-fg colour9
#setw -g window-status-bg colour18
#setw -g window-status-attr none
setw -g window-status-format ' #[fg=colour237] #[fg=colour250]#W#[fg=colour244]#F '
#setw -g window-status-bell-attr bold
#setw -g window-status-bell-fg colour255
#setw -g window-status-bell-bg colour1



set-option -g status-fg white
set-option -g status-bg default
#set-option -g status-attr default
#set-window-option -g window-status-fg "#666666"
#set-window-option -g window-status-bg default
#set-window-option -g window-status-attr default
#set-window-option -g window-status-current-fg red
#set-window-option -g window-status-current-bg default
#set-window-option -g window-status-current-attr default
#set-option -g message-fg white
#set-option -g message-bg black
#set-option -g message-attr bright
set -g status-justify left
