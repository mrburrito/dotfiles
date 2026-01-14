# shellcheck shell=bash

NVM_DIR="${HOME}/.nvm"
export NVM_DIR

# Load nvm
[[ -s "${NVM_DIR}/nvm.sh" ]] && \. "${NVM_DIR}/nvm.sh"
