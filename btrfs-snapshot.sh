#!/usr/bin/env bash

# Take snapshots of Btrfs subvolumes

# help output
help_output() {
    name=$(basename "$0")
    echo -e "$name: Take btrfs snapshots\n"

    echo -e "Usage:\n"

    echo "-h, --help            show this help"
    echo "-H, --home            take snapshot of the home subvolume"
    echo "-R, --root            take snapshot of the root subvolume"
    echo "-A, --all-snap        take snapshot of all subvolumes"
    echo "    --all-snap-auto   take snapshot of all subvolumes (meant for automated runs via cron or similar)"
}

# format for backup directory names
dir_format=$(date +%Y%m%d-%H%M%S)

# backup destination paths
manual_path='/btrfs-snapshots/manual'
auto_path='/btrfs-snapshots/auto'

# backup command
snapshot_command='btrfs subvolume snapshot'

# take snapshot of the home subvolume
home_snap() {
    mkdir -p "$manual_path"/home
    $snapshot_command /home "$manual_path"/home/"$dir_format"
}

# take snapshot of the root subvolume
root_snap() {
    mkdir -p "$manual_path"/root
    $snapshot_command / "$manual_path"/root/"$dir_format"
}

# take snapshot of all subvolumes
all_snap() {
    mkdir -p "$manual_path"/home
    mkdir -p "$manual_path"/root
    $snapshot_command /home "$manual_path"/home/"$dir_format"
    $snapshot_command / "$manual_path"/root/"$dir_format"
}

# take snapshot of all subvolumes (meant for use with cron)
all_snap_auto() {
    mkdir -p "$auto_path"/home
    mkdir -p "$auto_path"/root
    $snapshot_command /home "$auto_path"/home/"$dir_format"
    $snapshot_command / "$auto_path"/root/"$dir_format"
}

case "$1" in
    -H|--home)
        home_snap
        ;;

    -R|--root)
        root_snap
        ;;

    -A|--all-snap)
        all_snap
        ;;

    --all-snap-auto)
        all_snap_auto
        ;;

    -h|--help)
        help_output
        ;;

    *)
        help_output
        ;;
esac
