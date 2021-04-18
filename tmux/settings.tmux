# allow mouse scrolling
bind m set -g mouse\; display "Mouse Toggled"
set -g mouse on

# No delay for escape key press
set -sg escape-time 0

set-option -g renumber-windows on
set -g base-index 1
set -g pane-base-index 1
set-option -g repeat-time 0

set -g default-shell /usr/bin/zsh
set -g default-command /usr/bin/zsh

# Reload tmux config
bind r source-file ~/.tmux.conf \; display "Reloaded!"

#open window with currrent path                                                                   
bind c new-window -c '#{pane_current_path}' 

# Automatically set window title
set-window-option -g automatic-rename on
set-option -g set-titles on

# Set the default terminal mode to 256color mode
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",xterm-rxvt-unicode:Tc"

# set scrollback history to 10000 (10k)
set -g history-limit 10000

# kill session completely
bind q kill-session