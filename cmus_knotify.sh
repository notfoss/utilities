#!/usr/bin/env bash

# Displays the title/artist/album information for the current song being played
# by cmus in a kdialog notification popup.
# This is intended to be used as the status display program for cmus.

title=$(cmus-remote -Q | grep 'tag title' | cut -c 11-)
artist=$(cmus-remote -Q | grep 'tag artist' | cut -c 12-)
album=$(cmus-remote -Q | grep 'tag album ' | cut -c 11-)

kdialog --title "<strong>cmus</strong>" --passivepopup "<strong>title</strong>: $title<br><strong>artist</strong>: $artist<br><strong>album</strong>: $album"
