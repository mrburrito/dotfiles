# Prompt Settings
NC="\[\033[0m\]"
SC="\[\033[1;30m\]"
UC="\[\033[0;36m\]"
PC="\[\033[0;35m\]"
export PS1="$SC[$UC\u@\h$SC:$PC\W$SC]$NC \$ "

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
	eval `dircolors ~/.dir_colors`
fi
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias la='ls $LS_OPTIONS -ahF'
alias lA='ls $LS_OPTIONS -lahF'
