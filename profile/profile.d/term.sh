if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

function _git_is_dirty() {
  [[ -n "$(git status --porcelain 2> /dev/null)" ]]
}

function _git_is_git() {
  git rev-parse --abbrev-ref HEAD &>/dev/null
}

function _git_is_branch() {
  git symbolic-ref -q --short HEAD &>/dev/null
}

function _git_is_tag() {
  git describe --tags --exact-match &>/dev/null
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

# Prompt Settings
NC="\[${C_RESET}\]"
SC="\[${C_BOLD_BLACK}\]"
UC="\[${C_CYAN}\]"
PC="\[${C_PURPLE}\]"
GC="\[${C_YELLOW}\]"

function _git_prompt() {
  local color symbolic_name prefix
  if _git_is_git; then
    symbolic_name="$(_git_symbolic_name)"
    if _git_is_dirty; then
      color="${C_YELLOW}"
    fi
    if _git_is_branch; then
      color="${color:-${C_GREEN}}"
    elif _git_is_tag; then
      prefix="tag: "
      color="${color:-${C_BOLD_GREEN}}"
    else
      prefix="detached: "
      color="${color:-${C_RED}}"
    fi
    echo -e " ${color}(${prefix}${symbolic_name})$(_git_dirty_marker)${C_RESET}"
  fi
}

export PS1="${SC}[${UC}\u@\h${SC}:${PC}\W\$(_git_prompt)${SC}]${NC} \$ "

if [ "${TERM}" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
	eval `dircolors ~/.dir_colors`
fi
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias la='ls $LS_OPTIONS -ahF'
alias lA='ls $LS_OPTIONS -lahF'
