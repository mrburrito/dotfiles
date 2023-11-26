export PYENV_ROOT="${HOME}/.pyenv"
[[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"

alias spython='PYTHONPATH="src/main/python:$PYTHONPATH" python'
export PATH="${HOME}/.local/bin:${PATH}"
