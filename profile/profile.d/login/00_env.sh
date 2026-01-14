# shellcheck shell=bash

BREW_PREFIX=/opt/homebrew
export BREW_PREFIX

function _pathmunge() {
  if ! echo ${PATH} | "${BREW_PREFIX}/bin/ggrep" -q "(^|:)$1($|:)"; then
    if [[ "$2" == "after" ]]; then
      PATH="${PATH}:$1"
    else
      PATH="$1:${PATH}"
    fi
    export PATH
  fi
}

_pathmunge "${HOME}/bin"
_pathmunge "${BREW_PREFIX}/sbin"
_pathmunge "${BREW_PREFIX}/bin"
_pathmunge "${BREW_PREFIX}/opt/coreutils/libexec/gnubin"
_pathmunge "${BREW_PREFIX}/opt/grep/libexec/gnubin"
_pathmunge /usr/local/bin
_pathmunge /usr/local/sbin
_pathmunge /usr/libexec
