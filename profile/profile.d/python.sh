PYENV_ROOT="${HOME}/.pyenv"
export PYENV_ROOT

[[ -d "${PYENV_ROOT}/bin" ]] && _pathmunge "${PYENV_ROOT}/bin"
eval "$("${PYENV_ROOT}/bin/pyenv" init -)"

export PATH="${HOME}/.local/bin:${PATH}"
