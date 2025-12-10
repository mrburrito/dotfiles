#!/usr/bin/env bash

if ! declare -F is_kiro_agent >/dev/null 2>&1; then
  function is_kiro_agent() {
    [[ "${TERM_PROGRAM}" == "kiro" && "${Q_TERM_DISABLED:-}" == "1" ]]
  }
fi

# Kiro CLI pre block. Keep at the top of this file.
if ! is_kiro_agent; then
  [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.pre.bash"
fi

[[ -f ${HOME}/.bash_profile ]] && source ${HOME}/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source '/Users/gordon.shankman/.bash_completions/bteam.sh'


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

# Kiro CLI post block. Keep at the bottom of this file.
if ! is_kiro_agent; then
  [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash"
fi
