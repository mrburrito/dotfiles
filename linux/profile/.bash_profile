export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

alias cd..="cd .."
alias ..="cd .."
alias path='echo $PATH'

function _source {
  if [ -r "$1" ]; then
      if [ "${-#*1}" != "$-" ]; then
          . "$1"
      else
          . "$1" >/dev/null 2>&1
      fi
  fi
}

for prof in ~/.profile.d/*.sh ~/.bash_profile.local ~/.profile.d/.final; do
	_source ${prof}
done
