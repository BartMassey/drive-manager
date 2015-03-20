#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Mount encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

PGM="`basename $0`"
USAGE="$PGM: usage: $PGM [-t] [-e]"

ENSURE_ONLY=false
MDIR=backup

while [ $# -gt 0 ]
do
    case $1 in
    -t) MDIR=backup-tmp ;;
    -e) ENSURE_ONLY=true ;;
    *)  echo "$USAGE" >&2; exit 1 ;;
    esac
    shift
done

if ! [ -f /mnt/$MDIR/unmounted ]
then
    if $ENSURE_ONLY
    then
        exit 0
    fi
    echo "$PGM: drive already mounted" >&2
    exit 1
fi

CDIR=`sudo unlock-drive` &&
sudo mount -o relatime $CDIR /mnt/$MDIR
