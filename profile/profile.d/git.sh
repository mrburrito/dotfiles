function default_branch() {
    local branch
    branch="$(git branch -l main master --format '%(refname:short)' | head -n 1)"
    if [[ -z "${branch:-}" ]]; then
        echo >&2 "Unable to determine default branch!"
        return 1
    fi
    echo "${branch}"
}

function current_branch() {
    git rev-parse --abbrev-ref HEAD
}

function clean_branches() {
    local branches
    branches="$(git branch -l | grep -v -w "$(default_branch)" | grep -v -w "$(current_branch)")"
    if [[ -n "${branches:-}" ]]; then
        # shellcheck disable=SC2086
        git branch -D ${branches}
    fi
}

alias pullmain='git checkout $(default_branch) && git pull && git checkout -'
