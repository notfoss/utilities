#!/usr/bin/env bash

# Description
# ===========
# Check local git repositories for changes

# help
usage() {
    echo "git_check_status.sh: Check local git repositories for changes"
    echo
    echo "-h, --help            show this help"
    echo "-l, --list-dirs       list git repositories present under the current directory"
    echo "-q, --quiet           list the repositories containing changes, without showing the changes"
}

# find git repositories present under the current directory
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

if [[ $1 ]]; then
    case $1 in
        -h|--help)
            usage
            ;;
        -l|--list-dirs)
            listdirs
            ;;
        -q|--quiet)
            quiet_output
            ;;
        *)
            echo "Unrecognized option: $1"
            echo
            usage
            ;;
    esac
else
    verbose_output
fi
