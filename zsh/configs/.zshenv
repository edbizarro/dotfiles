if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Added by PAI installer — make bun reachable for hook subprocesses
export PATH="$HOME/.bun/bin:$PATH"

# Claude Code: keep conversation in Kitty native scrollback (hyperlinks, search, selection)
# PAIUpgrade 2026-05-10: discovered in claude-code v2.1.132 release notes
export CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1
