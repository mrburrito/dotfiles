VIRTUALENV_HOME=~/.pyenv

function venv_alias {
    name=`basename $venv`
    alias $name="source $venv/bin/activate"
    alias ${name}_refresh="deactivate 2>&1 >/dev/null; rm -rf $venv && virtualenv $venv && source $venv/bin/activate"
    alias ${name}_lib="ls $venv/lib/python*/site-packages"
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
}

function rmvenv {
	name=$1
	if [ -d $VIRTUALENV_HOME/$name ]; then
		echo "Removing virtualenv $name"
		rm -rf $VIRTUALENV_HOME/$name
		unalias $name
		unalias ${name}_refresh
		unalias ${name}_lib
	else
		echo "virturalenv $name does not exist"
	fi
}
