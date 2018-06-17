if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

get_git_prompt() {
	local branch
	if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
		if [[ "$branch" == "HEAD" ]]; then
			branch='detached*'
		fi
		# Determine dirty state; set color appropriately
		# clean: green
		# dirty: yellow
		local status=$(git status --porcelain 2> /dev/null)
		if [[ "${status}" != "" ]]; then
			echo " ($branch)"
		else
			echo " ($branch)"
		fi
	fi
}

get_git_status() {
	local status=$(git status --porcelain 2> /dev/null)
	if [[ "$status" != "" ]]; then
	 	echo "*"
	fi
}

# Prompt Settings
NC=${txtrst}
SC=${bldblk}
UC=${txtcyn}
PC=${txtpur}
GC=${txtylw}
export PS1="${SC}[${UC}\u@\h${SC}:${PC}\W${GC}\$(get_git_prompt)\$(get_git_status)${SC}]${NC} \$ "

if [ "${TERM}" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
	eval `dircolors ~/.dir_colors`
fi
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias la='ls $LS_OPTIONS -ahF'
alias lA='ls $LS_OPTIONS -lahF'
