VIRTUALENV_HOME=~/.pyenv

function venv_alias {
    local mkvenv_func=$1
    local venv=$2
    local name=`basename ${venv}`
    alias v_${name}="source ${venv}/bin/activate"
    alias v_${name}_refresh="deactivate 2>&1 >/dev/null; rmvenv ${name} && ${mkvenv_func} ${name} && source ${venv}/bin/activate"
    alias v_${name}_lib="ls ${venv}/lib/python*/site-packages"
}

for venv in ${VIRTUALENV_HOME}/*; do
    if [[ -f ${venv}/.mkvenv ]]; then
        mkvenv_func=$(cat ${venv}/.mkvenv)
    else
        mkvenv_func=mkvenv
    fi
    venv_alias ${mkvenv_func} ${venv};
done
alias lv='ls ${VIRTUALENV_HOME}'

function _mkvenv {
    mkvenv_func=$1
    shift
	name=$1
	venv_dir=${VIRTUALENV_HOME}/${name}
    shift
	if [ -d ${venv_dir} ]; then
		echo "virtualenv ${name} already exists"
		return 1
	fi
	virtualenv ${venv_dir} $*
	echo "${mkvenv_func}" > ${venv_dir}/.mkvenv
	venv_alias ${mkvenv_func} ${venv_dir}
    source ${venv_dir}/bin/activate
    #pip install -U pybuilder
}

function mkvenv {
    _mkvenv mkvenv $1
}

function mkvenv2 {
  _mkvenv mkvenv2 $1 -p python2
}

function mkvenv3 {
    _mkvenv mkvenv3 $1 -p python3
}

function rmvenv {
	name=$1
	if [ -d ${VIRTUALENV_HOME}/${name} ]; then
		echo "Removing virtualenv ${name}"
		rm -rf ${VIRTUALENV_HOME}/${name}
		unalias v_${name}
		unalias v_${name}_refresh
		unalias v_${name}_lib
	else
		echo "virtualenv ${name} does not exist"
	fi
}

alias spython='PYTHONPATH="src/main/python:$PYTHONPATH" python'
