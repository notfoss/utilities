#!/usr/bin/env bash

# Description
# ===========
# Check git repositories lying under the current directory
# for changes

gitdirs=$(find "$PWD" -type d -name ".git" | xargs dirname)

# list git repositories present under the current directory
listdirs() {
    echo -e "The following git repositories are present under the current directory:\n"
    for dir in $gitdirs; do
        echo "$dir"
    done
}

quiet_output() {
    for dir in $gitdirs; do
        cd "$dir"
        quiet_command=$(git status --porcelain)
        if [[ -n "$quiet_command" ]]; then
            printf '\e[1;37m'"${dir}:"'\e[0m'" Changes present\n"
        fi
    done
}

verbose_output() {
    for dir in $gitdirs; do
        cd "$dir"
        quiet_command=$(git status --porcelain)
        if [[ -n "$quiet_command" ]]; then
            printf '\e[1;37m'"Repository ${dir}\n\n"'\e[0m'
            git status
            echo '--------------------'
        fi
    done
}

case $1 in
    -l|--list-dirs)
        listdirs
        ;;
    -q|--quiet)
        quiet_output
        ;;
    *)
        verbose_output
        ;;
esac
