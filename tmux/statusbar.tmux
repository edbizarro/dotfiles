# ----------------------
# Status Bar
# -----------------------
set -g message-style bg="colour0",fg="colour6"
set -g message-command-style bg="colour0",fg="colour6"
set -g pane-active-border-style fg="colour1"
set -g pane-border-style fg="colour8"
set -g status "on"
set -g status-style "none"
set -g status-bg "colour0"
set -g status-justify "left"

set -g status-left "#[fg=colour232,bg=colour1] #S #[fg=colour1,bg=colour0,nobold,nounderscore,noitalics]"
set -g status-left-style "none"
set -g status-left-length "100"

set -g status-right "#[fg=colour1,bg=colour0,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour1] %R "
set -g status-right-style "none"
set -g status-right-length "100"

setw -g window-status-activity-style bg="colour0",fg="colour1","none"
setw -g window-status-style bg="colour0",fg="colour7","none"
setw -g window-status-current-format "#[fg=colour0,bg=colour0,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour1] #I #W #[fg=colour0,bg=colour0,nobold,nounderscore,noitalics]"
setw -g window-status-format "#[fg=colour0,bg=colour0,nobold,nounderscore,noitalics]#[default] #I #W #[fg=colour0,bg=colour0,nobold,nounderscore,noitalics]"
setw -g window-status-separator ""
