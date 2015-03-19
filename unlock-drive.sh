#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Unlock encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

MDRIVE=/dev/mapper/backup

if [ $# -ne 1 ]
then
    echo "unlock-drive: usage: unlock-drive <dev>" >&2
    exit 1
fi

if [ -e $MDRIVE ]
then
    echo $MDRIVE
    exit 0
fi

sudo cryptsetup create -c aes -s 128 backup "$1" </dev/tty &&
echo $MDRIVE
