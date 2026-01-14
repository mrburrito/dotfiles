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

if [[ -z "${PROFILED_LOGIN_LOADED:-}" ]]; then
  _source "${HOME}/.profile.d/login"
  PROFILED_LOGIN_LOADED=1
fi

_source "${HOME}/.profile.d/interactive"


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

# Kiro CLI post block. Keep at the bottom of this file.
if ! is_kiro_agent; then
  [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash"
fi
