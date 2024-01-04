NVM_DIR="${HOME}/.nvm"
export NVM_DIR

[[ -s "${BREW_PREFIX}/opt/nvm/nvm.sh" ]] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[[ -s "${BREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ]] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

alias npe='PATH="$(npm bin):$PATH"'
