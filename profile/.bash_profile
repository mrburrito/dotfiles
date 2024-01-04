# Set brew prefix
BREW_PREFIX="$(brew --prefix)"
export BREW_PREFIX

# Hide the user@host from the command prompt
HIDE_USER_PROMPT=1

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
_pathmunge "${BREW_PREFIX}/bin"
_pathmunge "${BREW_PREFIX}/opt/coreutils/libexec/gnubin"
_pathmunge "${BREW_PREFIX}/opt/grep/libexec/gnubin"
_pathmunge /usr/local/bin
_pathmunge /usr/local/sbin
_pathmunge /usr/libexec

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

_source "${HOME}/.profile.d"
_source "${HOME}/.bash_profile.local"
_source "${HOME}/.profile.d.local"
_source "${HOME}/.profile.d/.final"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
