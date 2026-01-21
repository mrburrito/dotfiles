# shellcheck shell=bash

alias npe='PATH="$(npm bin):$PATH"'

# Load nvm bash_completion
[[ -s "${NVM_DIR}/bash_completion" ]] && \. "${NVM_DIR}/bash_completion"

# Configure cd to check for .npmrc
function cdnvm() {
    local nvm_path default_version nvm_version locally_resolved_nvm_version

    command cd "$@" || return $?
    nvm_path="$(nvm_find_up .nvmrc | command tr -d '\n')"

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then
        default_version="$(nvm version default)"

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ ${default_version} == 'N/A' ]]; then
            nvm alias default node
            default_version=$(nvm version default)
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ "$(nvm current)" != "${default_version}" ]]; then
            nvm use default &>/dev/null
        fi
    elif [[ -s "${nvm_path}/.nvmrc" && -r "${nvm_path}/.nvmrc" ]]; then
        nvm_version=$(<"${nvm_path}"/.nvmrc)

        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors "${nvm_version}" | command tail -1 | command tr -d '\->*' | command tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [[ "${locally_resolved_nvm_version}" == 'N/A' ]]; then
            echo >&2 "Installing node ${nvm_version}..."
            nvm install "${nvm_version}"
        elif [[ "$(nvm current)" != "${locally_resolved_nvm_version}" ]]; then
            nvm use "${nvm_version}" &>/dev/null
        fi
    fi
}

alias cd='cdnvm'
cdnvm "$PWD" || exit
