#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Mount encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

PGM="`basename $0`"
USAGE="$PGM: usage: $PGM [-t]"

MDIR=backup
if [ $# -gt 0 ]
then
    case $1 in
    -t) MDIR=backup-tmp ;;
    *)  echo "$USAGE" >&2; exit 1 ;;
    esac
    shift
fi
if [ $# -gt 0 ]
then
    echo "$USAGE" >&2; exit 1
fi

DRIVE="`locate-drive backup`" &&
CDIR=`sudo unlock-drive "$DRIVE"` &&
sudo mount -o relatime $CDIR /mnt/$MDIR
