set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @resurrect-capture-pane-contents 'off'
set -g @resurrect-processes 'ssh'
set -g @continuum-restore 'on'

run '~/.tmux/plugins/tpm/tpm'
