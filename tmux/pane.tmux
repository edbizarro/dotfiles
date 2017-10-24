set -g pane-border-bg colour0
set -g pane-border-fg colour19
set -g pane-active-border-bg colour0
set -g pane-active-border-fg colour9

set -g pane-border-status off
set -g pane-border-format "\
#[fg=colour7,bg=colour2,bold] #{pane_index} \
#[fg=colour0,bg=colour0] \
#[fg=colour7,bg=colour5,bold]  #[fg=colour7,bg=colour8,bold] #{pane_current_command} \
"
