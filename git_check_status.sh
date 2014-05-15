#!/usr/bin/env bash

# Description
# ===========
# Check git repositories lying under the current directory
# for changes

gitdirs=$(find "$PWD" -type d -name ".git" | xargs dirname)

for dir in $gitdirs; do
    cd $dir

    # show only those repositories which contain changes
    sshort=$(git status --porcelain)
    if [[ -n "$sshort" ]]; then
        printf '\e[1;37m'"${dir}:"'\e[0m'" Changes present\n"
    fi
done
