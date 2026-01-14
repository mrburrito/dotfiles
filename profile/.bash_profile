#!/usr/bin/env bash

if ! declare -F is_kiro_agent >/dev/null 2>&1; then
  function is_kiro_agent() {
    [[ "${TERM_PROGRAM}" == "kiro" && "${Q_TERM_DISABLED:-}" == "1" ]]
  }
fi

if ! declare -F is_interactive >/dev/null 2>&1; then
  function is_interactive() {
    [[ $- == *i* ]]
  }
fi


# Kiro CLI pre block. Keep at the top of this file.
if ! is_kiro_agent; then
  [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.pre.bash"
fi

function _source {
  if [[ -d "$1" ]]; then
    for prof in "$1"/*.sh; do
      _source ${prof}
    done
  elif [[ -r "$1" ]]; then
    if [[ "${-#*1}" != "$-" ]]; then
      . "$1"
    else
      . "$1" &>/dev/null
    fi
  fi
}

_source "${HOME}/.profile.d/login"
PROFILED_LOGIN_LOADED=1
_source "${HOME}/.bash_profile.local"
_source "${HOME}/.profile.d.local"

if is_interactive; then
  [[ -f "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Kiro CLI post block. Keep at the bottom of this file.
if ! is_kiro_agent; then
  [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.post.bash"
fi
