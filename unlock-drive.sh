#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Unlock encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

MDRIVE=/dev/mapper/backup
if [ -e $MDRIVE ]
then
    echo $MDRIVE
    exit 0
fi

case $# in
    0)
        RDRIVE="`locate-drive backup`"
        if [ $? -ne 0 ]
        then
            echo "unlock-drive: failed to locate drive" >&2
            exit 1
        fi
        ;;
    1)
        RDRIVE="$1"
        ;;
    *)
        echo "unlock-drive: usage: unlock-drive [<dev>]" >&2
        exit 1
        ;;
esac

sudo cryptsetup create -c aes -s 128 backup "$RDRIVE" </dev/tty &&
echo $MDRIVE
