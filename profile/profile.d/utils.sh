alias myip='curl -s https://api.ipify.org?format=json | jq -r .ip'
alias pssh='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

alias path='echo $PATH'
alias ppath='echo $PATH | tr ":" "\n"'

# Turn off OS X attributes files in tar archives
alias tar='COPYFILE_DISABLE=1 tar'

if [[ "${TERM}" != "dumb" ]]; then
    export LS_OPTIONS='--color=auto'
    eval "$("${BREW_PREFIX}/bin/gdircolors" ~/.dir_colors)"
fi
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias la='ls $LS_OPTIONS -ahF'
alias lA='ls $LS_OPTIONS -lahF'
