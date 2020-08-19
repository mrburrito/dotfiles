function _git_is_dirty() {
  [[ -n "$(git status --porcelain 2> /dev/null)" ]]
}

function _git_is_git() {
  git rev-parse --abbrev-ref HEAD &>/dev/null
}

function _git_symbolic_name() {
  git symbolic-ref -q --short HEAD \
    || git describe --tags --exact-match 2> /dev/null \
    || git rev-parse --short HEAD
}

function _git_dirty_marker() {
  if _git_is_dirty; then
	 	echo "*"
	fi
}

function _git_prompt() {
  if _git_is_git; then
    echo " ($(_git_symbolic_name))$(_git_dirty_marker)"
  fi
}

# Prompt Settings
NC=${txtrst}
SC=${bldblk}
UC=${txtcyn}
PC=${txtpur}
GC=${txtylw}
export PS1="${SC}[${UC}\u@\h${SC}:${PC}\W${GC}\$(_git_prompt)${SC}]${NC} \$ "

if [ "${TERM}" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
	eval `dircolors ~/.dir_colors`
fi
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias la='ls $LS_OPTIONS -ahF'
alias lA='ls $LS_OPTIONS -lahF'
