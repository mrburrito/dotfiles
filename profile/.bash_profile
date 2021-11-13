export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:/usr/libexec:$PATH

alias cd..="cd .."
alias ..="cd .."
alias path='echo $PATH'
# Turn off OS X attributes files in tar archives
alias tar='COPYFILE_DISABLE=1 tar'

# Add brew to path
export PATH="/opt/homebrew/bin:${PATH}"

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

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
