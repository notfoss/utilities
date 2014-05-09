#!/usr/bin/env bash

# Description
# ===========
# Run Taskwarrior once everyday upon running a shell.
#
# Requirements
# ============
# Taskwarrior: http://taskwarrior.org/
#
# Usage
# =====
# Use one of your shell initialization files, such as
# ~/.bash_profile or ~/.bashrc to run this script.

# Declarations
# ============
# directory to store the timestamp file
taskdir="$HOME/.local/share/taskreminder"

# task report to run
taskcommand="task long"

# timestamp format
datecmd=$(date +%Y%m%d)

# Main
# ====
# create timestamp file
mkdir -p "$taskdir"
cd "$taskdir"

# run taskwarrior if the timestamp file doesn't exist
if [[ ! -e lastrun ]]; then
    $taskcommand
    echo $(date +%Y%m%d) > lastrun
    exit
fi

# run taskwarrior if the current date is greater than the timestamp
if [[ $(cat lastrun) -gt "$datecmd" ]]; then
    $taskcommand
    echo $(date +%Y%m%d) > lastrun
    exit
fi
