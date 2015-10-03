export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:/usr/libexec:$PATH
export EDITOR="/usr/local/bin/mate -w"

alias cd..="cd .."
alias ..="cd .."
alias path='echo $PATH'
# Turn off OS X attributes files in tar archives
alias tar='COPYFILE_DISABLE=1 tar'

function _source {
  if [ -r "$1" ]; then
      if [ "${-#*1}" != "$-" ]; then
          . "$1"
      else
          . "$1" >/dev/null 2>&1
      fi
  fi
}

export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

for i in ~/.profile.d/*.sh ~/.local ~/.profile.d/.final; do
	_source $i
done
