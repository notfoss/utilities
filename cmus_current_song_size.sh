#!/usr/bin/env bash

# Show the size of the song being currently played by cmus
# Requires zenity

# show size and filename
size=$(cmus-remote -Q | awk '/file/ { print $2 }' | xargs du -h | awk '{ print $1 }')
name=$(cmus-remote -Q | awk '/file/ { print $2 }' | xargs basename)

# zenity dialog
zenity --title=cmus-filesize --timeout=5 --info --text="[${size}] - ${name}"
