#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Unmount locked encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

PGM="`basename $0`"
USAGE="$PGM: usage: $PGM [-e]"

ENSURE_ONLY=false

while [ $# -gt 0 ]
do
    case "$1" in
        -e) ENSURE_ONLY=true; shift ;;
        *) echo "$USAGE" >&2; exit 1 ;;
    esac
done

if ! [ -e /dev/mapper/backup ] ||
   ( [ -f /mnt/backup/unmounted ] && [ -f /mnt/backup-tmp/unmounted ] )
then
    if $ENSURE_ONLY
    then
        exit 0
    else
        echo "umount-drive: drive not mounted" >&2
        exit 1
    fi
fi

if [ ! -f /mnt/backup/unmounted ]
then
        sudo umount /mnt/backup
fi 

if [ ! -f /mnt/backup-tmp/unmounted ]
then
        sudo umount /mnt/backup-tmp
fi

exit 0
