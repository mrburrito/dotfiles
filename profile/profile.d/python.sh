VIRTUALENV_HOME=~/.pyenv

function venv_alias {
    venv=$1
    name=`basename $venv`
    alias v_$name="source $venv/bin/activate"
    alias v_${name}_refresh="deactivate 2>&1 >/dev/null; rmvenv $name && mkvenv $name && source $venv/bin/activate"
    alias v_${name}_lib="ls $venv/lib/python*/site-packages"
}

for venv in $VIRTUALENV_HOME/*; do venv_alias $venv; done
alias lv='ls $VIRTUALENV_HOME'

function mkvenv {
	name=$1
	if [ -d $VIRTUALENV_HOME/$name ]; then
		echo "virtualenv $name already exists"
		return 1
	fi
	virtualenv $VIRTUALENV_HOME/$name
	venv_alias $VIRTUALENV_HOME/$name
        source $VIRTUALENV_HOME/$name/bin/activate
        pip install -U pybuilder
}

function rmvenv {
	name=$1
	if [ -d $VIRTUALENV_HOME/$name ]; then
		echo "Removing virtualenv $name"
		rm -rf $VIRTUALENV_HOME/$name
		unalias v_$name
		unalias v_${name}_refresh
		unalias v_${name}_lib
	else
		echo "virturalenv $name does not exist"
	fi
}

PIPSI_HOME=~/.pipsi-local
PIPSI_BIN=~/bin
export PIPSI_HOME PIPSI_BIN
alias pipsi='pipsi --home=$PIPSI_HOME --bin-dir=$PIPSI_BIN'

