# shellcheck shell=bash

if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi
