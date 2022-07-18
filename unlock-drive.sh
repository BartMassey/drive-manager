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

CHECK=true
DRIVE_CLASS=backup2
CRYPTSETUP_ARGS=""
CRYPT_TYPE="luks"

case "$1" in
    -n)
        CHECK=false
        shift
        ;;
    -o)
        DRIVE_CLASS=backup
        CRYPTSETUP_ARGS="-c aes -s 128"
        CRYPT_TYPE=plain
        shift
        ;;
esac
case $# in
    0)
        RDRIVE="`locate-drive $DRIVE_CLASS`"
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
        echo "unlock-drive: usage: unlock-drive [-o] [-n] [<dev>]" >&2
        exit 1
        ;;
esac

sudo cryptsetup $CRYPTSETUP_ARGS open \
  "$RDRIVE" backup --type $CRYPT_TYPE </dev/tty &&
if $CHECK
then
    if mount-drive
    then
        umount-drive
    else
        lock-drive
        echo "test mount failed: probably bad password" >&2
        exit 1
    fi
fi &&
echo $MDRIVE
