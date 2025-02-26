alias clean-docker='docker rm -f $(docker ps -aq) 2>/dev/null; docker rmi -f $(docker images -q) 2>/dev/null'
alias doco='docker compose'
