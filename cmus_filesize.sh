#!/usr/bin/env bash

# Display the file size of the song being currently played by cmus
# in a GUI dialog box.
# Requires zenity.

# Exit if zenity not present
hash zenity > /dev/null 2>&1 || { echo -e "Zenity not installed. Please install it before continuing.\n"; exit 1; }

cmus_running=$(cmus-remote > /dev/null 2>&1)

if [[ "$?" -ne 0 ]]; then
    echo -e "cmus not running. Exiting.\n"
    exit 1
fi

# show size and filename
size=$(cmus-remote -Q | awk '/file/ { print $2 }' | xargs du -h | awk '{ print $1 }')
name=$(cmus-remote -Q | awk '/file/ { print $2 }' | xargs basename)

# zenity dialog
zenity --title=cmus-filesize --timeout=5 --info --text="[${size}] - ${name}"
